resource "null_resource" "migrate_project" {
  triggers = {
    name                = var.project_name
    resource_group_name = var.resource_group_name
    location            = var.location
    description         = "Azure Migrate project placeholder for PMI infrastructure"
  }
}
