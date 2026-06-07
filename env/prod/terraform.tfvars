resource_group_name            = "PMI-PRD-USE-SHR-RG"
location                       = "East US"
tags = {
  environment = "prod"
  project     = "PMI"
}
vnet_name                      = "PMI-PRD-USE-VNET"
address_space                  = ["10.0.0.0/16"]
route_table_name               = "rt-shr"
public_ip_name                 = "pip-shr"
nat_gateway_name               = "nat-shr"
load_balancer_name             = "lb-shr"
application_gateway_name       = "agw-shr"
application_gateway_subnet_name = "AppGatewaySubnet"
firewall_name                  = "afw-prd"
firewall_subnet_name           = "AzureFirewallSubnet"
bastion_name                   = "bastion-prd"
bastion_subnet_name            = "AzureBastionSubnet"
private_dns_zone_name          = "pdns-pmi.local"
storage_account_name           = "pmiprdusemigsa"
key_vault_name                 = "kv-pmi-prd-use-shared"
application_insights_name      = "appi-pmi-prd-app"
log_analytics_name             = "law-pmi-prd-use"
sql_server_name                = "sql-prd-shr"
database_name                  = "sqldb-shr"
sql_administrator_login        = "sqladminuser"
sql_administrator_password     = "REPLACE_WITH_SQL_ADMIN_PASSWORD"

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
      address_prefix          = "10.0.5.0/27"
      nsg_name                = "nsg-shr-pvt"
      route_table_association = false
      subnet_type             = "service"
    },
    {
      name                    = "AzureBastionSubnet"
      address_prefix          = "10.0.6.0/27"
      nsg_name                = "nsg-shr-pvt"
      route_table_association = false
      subnet_type             = "service"
    },
    {
      name                    = "AppGatewaySubnet"
      address_prefix          = "10.0.7.0/27"
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

backup_policies = [
  { name = "bp-web" },
  { name = "bp-app" },
  { name = "bp-db" }
]

backup_protected_vms = [
  {
    vm_name           = "vm-web-01"
    backup_policy_name = "bp-web"
  },
  {
    vm_name           = "vm-app-01"
    backup_policy_name = "bp-app"
  },
  {
    vm_name           = "vm-db-01"
    backup_policy_name = "bp-db"
  },
]

asr_vault_name = "asr-prd"

replication_policies = [
  { name = "rp-web" },
  { name = "rp-app" },
  { name = "rp-db" }
]

migrate_project_name   = "mig-pmi-infra"
migrate_appliance_name = "migapp-01"
migration_wave_name    = "wave-01"
cutover_batch_name     = "batch-01"
dms_name               = "dms-pmi"
