output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = { for s in azurerm_subnet.this : s.key => s.value.id }
}

output "public_ip_id" {
  value = azurerm_public_ip.this.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.this.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.this.id
}
