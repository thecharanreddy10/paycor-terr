resource "azurerm_subnet" "this" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = {
    for s in var.subnets : s.name => s
    if try(s.nsg_name, "") != "" && !contains(["AzureFirewallSubnet", "AzureBastionSubnet", "GatewaySubnet"], s.name)
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.value.nsg_name].id
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = {
    for s in var.subnets : s.name => s
    if s.route_table_association && !contains(["AzureFirewallSubnet", "AzureBastionSubnet", "GatewaySubnet"], s.name)
  }

  subnet_id      = azurerm_subnet.this[each.key].id
  route_table_id = azurerm_route_table.this.id
}
