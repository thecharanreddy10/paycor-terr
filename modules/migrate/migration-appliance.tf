resource "azurerm_migrate_appliance" "this" {
  name                = var.appliance_name
  migrate_project_id  = azurerm_migrate_project.this.id
  resource_group_name = var.resource_group_name
  location            = var.location
}
