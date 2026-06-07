output "vm_ids" {
  value = { for name, vm in azurerm_linux_virtual_machine.this : name => vm.id }
}

output "vm_private_ips" {
  value = { for name, nic in azurerm_network_interface.this : name => nic.ip_configuration[0].private_ip_address }
}
