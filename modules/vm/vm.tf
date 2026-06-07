resource "azurerm_linux_virtual_machine" "this" {
  for_each = { for vm in var.vm_definitions : vm.name => vm }

  name                            = each.key
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.this[each.key].id]
  size                            = each.value.vm_size
  admin_username                  = each.value.admin_username
  computer_name                   = each.value.computer_name
  disable_password_authentication = true

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = each.value.admin_ssh_key
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

  boot_diagnostics {}
}
