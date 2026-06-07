resource "azurerm_backup_protected_vm" "this" {
  for_each = { for vm in var.protected_vms : vm.name => vm }

  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  source_vm_id        = each.value.vm_id
  backup_policy_id    = azurerm_backup_policy_vm.this[each.value.policy_name].id
}
