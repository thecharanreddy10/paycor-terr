resource "azurerm_site_recovery_replication_policy" "this" {
  for_each = { for p in var.replication_policies : p.name => p }

  name                                                 = each.value.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.this.name
  recovery_point_retention_in_minutes                  = 24 * 60
  application_consistent_snapshot_frequency_in_minutes = 4 * 60
}
