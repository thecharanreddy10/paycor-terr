resource "azurerm_site_recovery_protection_policy" "this" {
  for_each = { for p in var.replication_policies : p.name => p }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_site_recovery_vault.this.name
  replication_provider = "HyperVReplicaAzure"
  recovery_point_history = 24
  application_consistent_snapshot_frequency_in_hours = 4
}
