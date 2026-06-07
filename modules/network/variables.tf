variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = list(object({
    name                    = string
    address_prefix          = string
    nsg_name                = string
    route_table_association = bool
    subnet_type             = string
  }))
}

variable "nsgs" {
  type = list(object({
    name = string
    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
  }))
}

variable "route_table_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "load_balancer_name" {
  type = string
}

variable "application_gateway_name" {
  type = string
}

variable "application_gateway_subnet_name" {
  type = string
}

variable "firewall_name" {
  type = string
}

variable "firewall_subnet_name" {
  type = string
}

variable "bastion_name" {
  type = string
}

variable "bastion_subnet_name" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "private_endpoints" {
  type = list(object({
    name                  = string
    subnet_name           = string
    target_resource_id    = string
    subresource_names     = list(string)
    private_dns_zone_name = string
  }))
  default = []
}
