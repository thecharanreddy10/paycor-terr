resource_group_name = "PAY-UAT-EUS2-APP-RG"
location            = "East US 2"
tags = {
  environment = "dev"
  project     = "Paycor"
}
vnet_name                       = "PAY-UAT-EUS2-VNET"
address_space                   = ["10.0.0.0/16"]
route_table_name                = "rt-app"
public_ip_name                  = "pip-app"
nat_gateway_name                = "nat-app"
load_balancer_name              = "lb-app"
application_gateway_name        = "agw-app"
application_gateway_subnet_name = "AppGatewaySubnet"
firewall_name                   = "afw-uat"
firewall_subnet_name            = "AzureFirewallSubnet"
bastion_name                    = "bastion-uat"
bastion_subnet_name             = "AzureBastionSubnet"
private_dns_zone_name           = "pdns-paycor.local"
storage_account_name            = "payuateus2appsa"
key_vault_name                  = "kv-pay-uat-eus2-app"
application_insights_name       = "appi-pay-uat-app"
log_analytics_name              = "law-pay-uat-eus2"
sql_server_name                 = "sql-uat-app"
database_name                   = "sqldb-app"
sql_administrator_login         = "paycor_sql_admin"
policy_definition_name          = "pol-uat-baseline"
initiative_name                 = "pol-uat-baseline"
assignment_name                 = "pol-uat-baseline"
recovery_vault_name             = "rsv-uat"
asr_vault_name                  = "asr-uat"
replication_policies = [
  { name = "rp-web" },
  { name = "rp-app" },
  { name = "rp-db" },
]
migrate_project_name   = "mig-paycor-infra"
migrate_appliance_name = "migapp-01"
migration_wave_name    = "wave-01"
cutover_batch_name     = "batch-01"
dms_name               = "dms-paycor"

subnets = [
  {
    name                    = "snet-web"
    address_prefix          = "10.0.1.0/24"
    nsg_name                = "nsg-app-web"
    route_table_association = true
    subnet_type             = "application"
  },
  {
    name                    = "snet-app"
    address_prefix          = "10.0.2.0/24"
    nsg_name                = "nsg-app-app"
    route_table_association = true
    subnet_type             = "application"
  },
  {
    name                    = "snet-db"
    address_prefix          = "10.0.3.0/24"
    nsg_name                = "nsg-app-db"
    route_table_association = true
    subnet_type             = "database"
  },
  {
    name                    = "snet-pvt-edp"
    address_prefix          = "10.0.4.0/24"
    nsg_name                = "nsg-app-pvt"
    route_table_association = true
    subnet_type             = "private"
  },
  {
    name                    = "AzureFirewallSubnet"
    address_prefix          = "10.0.5.0/26"
    nsg_name                = "nsg-app-pvt"
    route_table_association = false
    subnet_type             = "service"
  },
  {
    name                    = "AzureBastionSubnet"
    address_prefix          = "10.0.6.0/26"
    nsg_name                = "nsg-app-pvt"
    route_table_association = false
    subnet_type             = "service"
  },
  {
    name                    = "AppGatewaySubnet"
    address_prefix          = "10.0.7.0/26"
    nsg_name                = "nsg-app-web"
    route_table_association = false
    subnet_type             = "service"
  },
]

nsgs = [
  {
    name = "nsg-app-web"
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
    name = "nsg-app-app"
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
    name = "nsg-app-db"
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
    name = "nsg-app-pvt"
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
    name            = "sqlvm-app-01"
    computer_name   = "sqlvm-app-01"
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
