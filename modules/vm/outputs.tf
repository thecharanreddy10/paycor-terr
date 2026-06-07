output "vm_ids" {
  value = { for vm in azurerm_linux_virtual_machine.this : vm.key => vm.value.id }
}

output "vm_private_ips" {
  value = { for nic in azurerm_network_interface.this : nic.key => nic.value.ip_configuration[0].private_ip_address }
}
