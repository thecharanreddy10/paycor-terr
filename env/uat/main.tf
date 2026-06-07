terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  required_version = "~> 1.8"
}

provider "azurerm" {
  features {}
}

module "rg" {
  source   = "../../modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "../../modules/network"

  resource_group_name             = module.rg.name
  location                        = var.location
  vnet_name                       = var.vnet_name
  address_space                   = var.address_space
  subnets                         = var.subnets
  nsgs                            = var.nsgs
  route_table_name                = var.route_table_name
  public_ip_name                  = var.public_ip_name
  nat_gateway_name                = var.nat_gateway_name
  load_balancer_name              = var.load_balancer_name
  application_gateway_name        = var.application_gateway_name
  application_gateway_subnet_name = var.application_gateway_subnet_name
  firewall_name                   = var.firewall_name
  firewall_subnet_name            = var.firewall_subnet_name
  bastion_name                    = var.bastion_name
  bastion_subnet_name             = var.bastion_subnet_name
  private_dns_zone_name           = var.private_dns_zone_name
  private_endpoints               = local.private_endpoints
}

module "storage" {
  source              = "../../modules/storage"
  name                = var.storage_account_name
  resource_group_name = module.rg.name
  location            = var.location
}

module "key_vault" {
  source              = "../../modules/key-vault"
  name                = var.key_vault_name
  resource_group_name = module.rg.name
  location            = var.location
}

module "sql" {
  source                       = "../../modules/sql"
  resource_group_name          = module.rg.name
  location                     = var.location
  server_name                  = var.sql_server_name
  database_name                = var.database_name
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_password
}

module "vm" {
  source              = "../../modules/vm"
  resource_group_name = module.rg.name
  location            = var.location
  subnet_ids          = module.network.subnet_ids
  vm_definitions      = var.vm_definitions
}

module "monitoring" {
  source                    = "../../modules/monitoring"
  resource_group_name       = module.rg.name
  location                  = var.location
  workspace_name            = var.log_analytics_name
  application_insights_name = var.application_insights_name
  retention_in_days         = var.monitoring_retention_in_days
  alert_rules               = local.alert_rules
  diagnostic_settings       = local.diagnostic_settings
}

module "policy" {
  source                 = "../../modules/policy"
  policy_definition_name = var.policy_definition_name
  initiative_name        = var.initiative_name
  assignment_name        = var.assignment_name
  scope                  = module.rg.id
}

module "backup" {
  source               = "../../modules/backup"
  resource_group_name  = module.rg.name
  location             = var.location
  recovery_vault_name  = var.recovery_vault_name
  backup_policies      = var.backup_policies
  protected_vms        = local.backup_protected_vms
  asr_vault_name       = var.asr_vault_name
  replication_policies = var.replication_policies
}

module "migrate" {
  source              = "../../modules/migrate"
  resource_group_name = module.rg.name
  location            = var.location
  project_name        = var.migrate_project_name
  appliance_name      = var.migrate_appliance_name
  migration_wave_name = var.migration_wave_name
  cutover_batch_name  = var.cutover_batch_name
}

module "dms" {
  source              = "../../modules/dms"
  name                = var.dms_name
  resource_group_name = module.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_ids["snet-pvt-edp"]
}

locals {
  private_endpoints = [
    {
      name                  = "pep-kv"
      subnet_name           = "snet-pvt-edp"
      target_resource_id    = module.key_vault.id
      subresource_names     = ["vault"]
      private_dns_zone_name = "privatelink.vaultcore.azure.net"
    },
    {
      name                  = "pep-sql"
      subnet_name           = "snet-pvt-edp"
      target_resource_id    = module.sql.server_id
      subresource_names     = ["sqlServer"]
      private_dns_zone_name = "privatelink.database.windows.net"
    },
    {
      name                  = "pep-storage"
      subnet_name           = "snet-pvt-edp"
      target_resource_id    = module.storage.id
      subresource_names     = ["blob"]
      private_dns_zone_name = "privatelink.blob.core.windows.net"
    },
  ]

  alert_rules = [
    {
      name               = "alert-web-cpu"
      target_resource_id = module.vm.vm_ids["vm-web-01"]
      description        = "Web VM CPU utilization alert"
      severity           = 2
      metric_namespace   = "Microsoft.Compute/virtualMachines"
      metric_name        = "Percentage CPU"
      aggregation        = "Average"
      operator           = "GreaterThan"
      threshold          = 80
    },
    {
      name               = "alert-db-memory"
      target_resource_id = module.sql.server_id
      description        = "SQL Server memory utilization alert"
      severity           = 2
      metric_namespace   = "Microsoft.Sql/servers"
      metric_name        = "memory_percent"
      aggregation        = "Average"
      operator           = "GreaterThan"
      threshold          = 80
    },
  ]

  diagnostic_settings = [
    {
      name               = "diag-kv"
      target_resource_id = module.key_vault.id
      log_categories     = ["AuditEvent"]
    },
    {
      name               = "diag-storage"
      target_resource_id = "${module.storage.id}/blobServices/default"
      log_categories     = ["StorageRead", "StorageWrite", "StorageDelete"]
    },
    {
      name               = "diag-law"
      target_resource_id = module.sql.server_id
      log_categories     = ["SQLSecurityAuditEvents"]
    },
  ]

  backup_protected_vms = [
    for protected in var.backup_protected_vms : {
      name        = protected.vm_name
      vm_id       = module.vm.vm_ids[protected.vm_name]
      policy_name = protected.backup_policy_name
    }
  ]
}

output "resource_group_id" {
  value = module.rg.id
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "storage_account_id" {
  value = module.storage.id
}
