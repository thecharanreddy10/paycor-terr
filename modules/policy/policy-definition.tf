resource "azurerm_policy_definition" "this" {
  name         = var.policy_definition_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "PMI baseline policy definition"
  description  = "Audits resources that do not have required baseline tags."

  parameters = jsonencode({
    requiredTagName = {
      type = "String"
      metadata = {
        displayName = "Required tag name"
      }
      defaultValue = "environment"
    }
  })

  policy_rule = jsonencode({
    if = {
      field  = "[concat('tags[', parameters('requiredTagName'), ']')]"
      exists = "false"
    }
    then = {
      effect = "audit"
    }
  })
}
