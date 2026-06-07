# terr-v2 Terraform Azure Landing Zone

This repository contains Terraform code for deploying PMI Azure infrastructure across `dev`, `qa`, `uat`, and `prod` environments.

## Repository structure

```text
env/
	dev/   # Dev root module and backend configuration
	qa/    # QA root module and backend configuration
	uat/   # UAT root module and backend configuration
	prod/  # Production root module and backend configuration
modules/
	backup/
	dms/
	key-vault/
	migrate/
	monitoring/
	network/
	policy/
	resource-group/
	sql/
	storage/
	vm/
```

Each environment calls the shared modules under `modules/` and supplies environment-specific values from its own `terraform.tfvars` file.

## Prerequisites

- Terraform `1.8.x`
- AzureRM provider `~> 3.116`
- Azure subscription access with least-privilege permissions
- Remote state storage account/container created before first `terraform init`
- Azure DevOps service connection with access to the target subscription and backend state storage

## Remote state

Each environment uses a separate Azure Storage backend configuration:

| Environment | Backend file |
|---|---|
| dev | `env/dev/backend.tf` |
| qa | `env/qa/backend.tf` |
| uat | `env/uat/backend.tf` |
| prod | `env/prod/backend.tf` |

Bootstrap the backend storage account and `tfstate` container before running Terraform for an environment. The state storage account should have:

- Private endpoint or restricted network access
- Blob versioning and soft delete
- RBAC-only access where possible
- Diagnostic logs enabled
- No shared public anonymous access

## Secret handling

Do not commit passwords, private keys, access keys, client secrets, or real `.auto.tfvars` files.

The SQL administrator password is intentionally not stored in `terraform.tfvars`. Provide it using one of these methods:

- Azure DevOps variable group `terr-v2-secrets` with secret variable `sqlAdministratorPassword`
- Local environment variable: `TF_VAR_sql_administrator_password`
- A local-only variable file excluded from Git

Example local flow:

```powershell
$env:TF_VAR_sql_administrator_password = '<secure-password>'
cd env/dev
terraform init
terraform plan
```

## Azure DevOps pipeline

[azure-pipelines.yml](azure-pipelines.yml) implements:

1. Terraform installation
2. `terraform fmt -check -recursive`
3. `terraform init -backend=false`
4. `terraform validate`
5. Backend `terraform init`
6. `terraform plan` with a saved plan artifact
7. Manual approval before apply
8. `terraform apply` using the saved plan artifact

Before running the pipeline:

1. Replace `REPLACE_WITH_AZURE_SERVICE_CONNECTION_NAME` in [azure-pipelines.yml](azure-pipelines.yml) with the Azure DevOps service connection name.
2. Create variable group `terr-v2-secrets`.
3. Add secret variable `sqlAdministratorPassword`.
4. Ensure the service connection has access to the selected environment state backend and target subscription.

## Security baseline applied

- Key Vault purge protection enabled
- Key Vault network default action set to deny
- Key Vault RBAC authorization enabled
- SQL moved to `azurerm_mssql_server` / `azurerm_mssql_database`
- SQL public network access disabled
- SQL password marked sensitive
- Storage public network access disabled
- Storage blob versioning and delete retention enabled
- Separate public IPs for Bastion, Firewall, NAT Gateway, Load Balancer, and Application Gateway
- Azure Firewall is used as the default egress route target
- Application Gateway uses WAF_v2
- Log Analytics retention is configurable per environment
- Terraform state, local plans, and local variable files are ignored by Git

## Recommended workflow

For a non-production change:

```powershell
cd env/dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

For production, use the pipeline and apply only after reviewing the published plan artifact.

## Important notes

- The committed `terraform.tfvars` files should contain only non-secret defaults and environment-specific names.
- The backend storage accounts must exist before Terraform can initialize remote state.
- The pipeline uses Azure CLI authentication from the configured Azure DevOps service connection.
- Private endpoints require correct DNS resolution from the deployment network.
- Application Gateway HTTPS certificates should be integrated from Key Vault before exposing production workloads publicly.

## Next improvements

- Refactor duplicated environment `main.tf` files into a common root composition module.
- Add TFLint, Checkov/tfsec, and Infracost stages to the pipeline.
- Add action groups and production-grade alert routing.
- Add Azure Policy assignments for Defender, encryption, allowed SKUs, and required tags.
- Add generated architecture diagrams and a backend bootstrap script.
