output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}

output "public_ip_id" {
  value = azurerm_public_ip.load_balancer.id
}

output "application_gateway_public_ip_id" {
  value = azurerm_public_ip.application_gateway.id
}

output "firewall_public_ip_id" {
  value = azurerm_public_ip.firewall.id
}

output "bastion_public_ip_id" {
  value = azurerm_public_ip.bastion.id
}

output "nat_gateway_public_ip_id" {
  value = azurerm_public_ip.nat_gateway.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.this.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.this.id
}

output "private_endpoint_dns_zone_ids" {
  value = { for name, zone in azurerm_private_dns_zone.private_endpoint : name => zone.id }
}
