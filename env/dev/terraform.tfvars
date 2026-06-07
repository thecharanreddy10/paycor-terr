resource_group_name = "PMI-DEV-USE-SHR-RG"
location            = "East US"
tags = {
  environment = "dev"
  project     = "PMI"
}
vnet_name                       = "PMI-DEV-USE-VNET"
address_space                   = ["10.0.0.0/16"]
route_table_name                = "rt-shr"
public_ip_name                  = "pip-shr"
nat_gateway_name                = "nat-shr"
load_balancer_name              = "lb-shr"
application_gateway_name        = "agw-shr"
application_gateway_subnet_name = "AppGatewaySubnet"
firewall_name                   = "afw-dev"
firewall_subnet_name            = "AzureFirewallSubnet"
bastion_name                    = "bastion-dev"
bastion_subnet_name             = "AzureBastionSubnet"
private_dns_zone_name           = "pdns-pmi.local"
storage_account_name            = "pmidevusemigsa"
key_vault_name                  = "kv-pmi-dev-use-shared"
application_insights_name       = "appi-pmi-dev-app"
log_analytics_name              = "law-pmi-dev-use"
sql_server_name                 = "sql-dev-shr"
database_name                   = "sqldb-dev"
sql_administrator_login         = "pmi_dev_sql_admin"
policy_definition_name          = "pol-dev-baseline"
initiative_name                 = "pol-dev-baseline"
assignment_name                 = "pol-dev-baseline"
recovery_vault_name             = "rsv-dev"
asr_vault_name                  = "asr-dev"
replication_policies = [
  { name = "rp-web" },
  { name = "rp-app" },
  { name = "rp-db" },
]
migrate_project_name   = "mig-pmi-infra-dev"
migrate_appliance_name = "migapp-dev-01"
migration_wave_name    = "wave-01"
cutover_batch_name     = "batch-01"
dms_name               = "dms-pmi-dev"

subnets = [
  {
    name                    = "snet-web"
    address_prefix          = "10.0.1.0/24"
    nsg_name                = "nsg-shr-web"
    route_table_association = true
    subnet_type             = "application"
  },
  {
    name                    = "snet-app"
    address_prefix          = "10.0.2.0/24"
    nsg_name                = "nsg-shr-app"
    route_table_association = true
    subnet_type             = "application"
  },
  {
    name                    = "snet-db"
    address_prefix          = "10.0.3.0/24"
    nsg_name                = "nsg-shr-db"
    route_table_association = true
    subnet_type             = "database"
  },
  {
    name                    = "snet-pvt-edp"
    address_prefix          = "10.0.4.0/24"
    nsg_name                = "nsg-shr-pvt"
    route_table_association = true
    subnet_type             = "private"
  },
  {
    name                    = "AzureFirewallSubnet"
    address_prefix          = "10.0.5.0/26"
    nsg_name                = "nsg-shr-pvt"
    route_table_association = false
    subnet_type             = "service"
  },
  {
    name                    = "AzureBastionSubnet"
    address_prefix          = "10.0.6.0/26"
    nsg_name                = "nsg-shr-pvt"
    route_table_association = false
    subnet_type             = "service"
  },
  {
    name                    = "AppGatewaySubnet"
    address_prefix          = "10.0.7.0/26"
    nsg_name                = "nsg-shr-web"
    route_table_association = false
    subnet_type             = "service"
  },
]

nsgs = [
  {
    name = "nsg-shr-web"
    security_rules = [
      {
        name                       = "AllowHTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      }
    ]
  },
  {
    name = "nsg-shr-app"
    security_rules = [
      {
        name                       = "AllowApp"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
      }
    ]
  },
  {
    name = "nsg-shr-db"
    security_rules = [
      {
        name                       = "AllowSql"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
      }
    ]
  },
  {
    name = "nsg-shr-pvt"
    security_rules = [
      {
        name                       = "AllowInternal"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
      }
    ]
  },
]

vm_definitions = [
  {
    name            = "vm-web-01"
    computer_name   = "vm-web-01"
    subnet_name     = "snet-web"
    vm_size         = "Standard_B2s"
    admin_username  = "azureuser"
    admin_ssh_key   = "REPLACE_WITH_SSH_PUBLIC_KEY"
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  },
  {
    name            = "vm-app-01"
    computer_name   = "vm-app-01"
    subnet_name     = "snet-app"
    vm_size         = "Standard_B2s"
    admin_username  = "azureuser"
    admin_ssh_key   = "REPLACE_WITH_SSH_PUBLIC_KEY"
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  },
  {
    name            = "vm-db-01"
    computer_name   = "vm-db-01"
    subnet_name     = "snet-db"
    vm_size         = "Standard_B4ms"
    admin_username  = "azureuser"
    admin_ssh_key   = "REPLACE_WITH_SSH_PUBLIC_KEY"
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  },
  {
    name            = "sqlvm-shr-01"
    computer_name   = "sqlvm-shr-01"
    subnet_name     = "snet-db"
    vm_size         = "Standard_D4s_v3"
    admin_username  = "azureuser"
    admin_ssh_key   = "REPLACE_WITH_SSH_PUBLIC_KEY"
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  },
]
