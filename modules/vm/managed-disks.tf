resource "azurerm_managed_disk" "this" {
  for_each = { for vm in var.vm_definitions : vm.name => vm }

  name                 = "${each.key}-osdisk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
}
