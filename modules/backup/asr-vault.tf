resource "azurerm_site_recovery_vault" "this" {
  name                = var.asr_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}
