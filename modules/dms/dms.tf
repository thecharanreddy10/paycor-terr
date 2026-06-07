resource "null_resource" "this" {
  triggers = {
    name                = var.name
    resource_group_name = var.resource_group_name
    location            = var.location
    subnet_id           = var.subnet_id
  }
}
