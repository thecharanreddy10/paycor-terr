resource "azurerm_subnet" "this" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]
  network_security_group_id = try(azurerm_network_security_group.this[each.value.nsg_name].id, null)
  route_table_id           = each.value.route_table_association ? azurerm_route_table.this.id : null
}
