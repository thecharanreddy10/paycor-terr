resource "null_resource" "migration_appliance" {
  triggers = {
    name                = var.appliance_name
    migrate_project_id  = null_resource.migrate_project.id
    resource_group_name = var.resource_group_name
    location            = var.location
  }
}
