resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.this[var.firewall_subnet_name].id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}
