data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = "standard"
  soft_delete_retention_days      = 90
  purge_protection_enabled        = true
  enable_rbac_authorization       = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}