resource "azurerm_policy_set_definition" "this" {
  name         = var.initiative_name
  display_name = "PMI production baseline initiative"
  policy_type  = "Custom"
  description  = "Group of baseline policies for PMI production"

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.this.id
  }
}
