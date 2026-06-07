resource "azurerm_network_interface" "this" {
  for_each = { for vm in var.vm_definitions : vm.name => vm }

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_ids[each.value.subnet_name]
    private_ip_address_allocation = "Dynamic"
  }
}
