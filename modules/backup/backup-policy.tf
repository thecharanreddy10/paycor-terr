resource "azurerm_backup_policy_vm" "this" {
  for_each = { for p in var.backup_policies : p.name => p }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  timezone            = "UTC"

  backup {
    frequency = "Daily"
    time      = "03:00"
  }

  retention_daily {
    count = 7
  }
}