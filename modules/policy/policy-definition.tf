resource "azurerm_policy_definition" "this" {
  name         = var.policy_definition_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "PMI baseline policy definition"
  policy_rule  = <<POLICY
{
  "if": {
    "field": "tags",
    "exists": "false"
  },
  "then": {
    "effect": "audit"
  }
}
POLICY
}
