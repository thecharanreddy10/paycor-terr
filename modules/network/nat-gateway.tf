resource "azurerm_nat_gateway" "this" {
  name                = var.nat_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = { for s in var.subnets : s.name => s if s.subnet_type == "private" }

  subnet_id      = azurerm_subnet.this[each.key].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}
