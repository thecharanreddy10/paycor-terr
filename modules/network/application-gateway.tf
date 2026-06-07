resource "azurerm_application_gateway" "this" {
  name                = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }
  autoscale_configuration {
    min_capacity = 1
    max_capacity = 3
  }
  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }
  gateway_ip_configuration {
    name      = "appgw_ip_config"
    subnet_id = azurerm_subnet.this[var.application_gateway_subnet_name].id
  }
  frontend_port {
    name = "frontendPort"
    port = 80
  }
  frontend_ip_configuration {
    name                 = "frontendIp"
    public_ip_address_id = azurerm_public_ip.application_gateway.id
  }
  backend_address_pool {
    name = "backendPool"
  }
  probe {
    name                = "http-probe"
    protocol            = "Http"
    host                = "127.0.0.1"
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
  }
  backend_http_settings {
    name                  = "httpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "http-probe"
  }
  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIp"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpSettings"
  }
}
