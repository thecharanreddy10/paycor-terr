resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_name            = "${var.bastion_name}-${replace(var.location, " ", "")}" 
  ip_configuration {
    name                 = "bastion-ip"
    subnet_id            = azurerm_subnet.this[var.bastion_subnet_name].id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}
