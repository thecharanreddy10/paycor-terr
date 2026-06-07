resource "azurerm_route_table" "this" {
  name                = var.route_table_name
  resource_group_name = var.resource_group_name
  location            = var.location

  route {
    name                   = "default-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  }
}
