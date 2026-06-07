resource "azurerm_resource_group_policy_assignment" "this" {
  name                 = var.assignment_name
  resource_group_id    = var.scope
  policy_definition_id = azurerm_policy_set_definition.this.id
  display_name         = "PMI production policy assignment"
}
