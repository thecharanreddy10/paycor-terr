output "recovery_vault_id" {
  value = azurerm_recovery_services_vault.this.id
}

output "asr_vault_id" {
  value = azurerm_site_recovery_vault.this.id
}
