variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
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

variable "storage_account_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "application_insights_name" {
  type = string
}

variable "log_analytics_name" {
  type = string
}

variable "sql_server_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "sql_administrator_login" {
  type = string
}

variable "sql_administrator_password" {
  type      = string
  sensitive = true
}

variable "monitoring_retention_in_days" {
  type    = number
  default = 90
}

variable "vm_definitions" {
  type = list(object({
    name            = string
    computer_name   = string
    subnet_name     = string
    vm_size         = string
    admin_username  = string
    admin_ssh_key   = string
    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = string
  }))
}

variable "backup_policies" {
  type = list(object({
    name = string
  }))
  default = []
}

variable "backup_protected_vms" {
  type = list(object({
    vm_name            = string
    backup_policy_name = string
  }))
  default = []
}

variable "asr_vault_name" {
  type = string
}

variable "replication_policies" {
  type = list(object({
    name = string
  }))
}

variable "policy_definition_name" {
  type = string
}

variable "initiative_name" {
  type = string
}

variable "assignment_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "migrate_project_name" {
  type = string
}

variable "migrate_appliance_name" {
  type = string
}

variable "migration_wave_name" {
  type = string
}

variable "cutover_batch_name" {
  type = string
}

variable "dms_name" {
  type = string
}
