resource "azurerm_migrate_project" "this" {
  name                = var.project_name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Azure Migrate project for PMI infrastructure"
}
