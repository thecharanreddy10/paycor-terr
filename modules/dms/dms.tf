resource "azurerm_data_migration_service" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard_1"
  virtual_subnet_id   = var.subnet_id
}
