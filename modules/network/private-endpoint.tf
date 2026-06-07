resource "azurerm_private_endpoint" "this" {
  for_each = { for pe in var.private_endpoints : pe.name => pe }

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.this[each.value.subnet_name].id

  private_service_connection {
    name                           = "psc-${each.value.name}"
    private_connection_resource_id = each.value.target_resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone_group" "this" {
  for_each = azurerm_private_endpoint.this

  name                 = "zonegroup-${each.key}"
  private_endpoint_id  = each.value.id
  private_dns_zone_id  = azurerm_private_dns_zone.this.id
}
