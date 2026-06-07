variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_ids" {
  type = map(string)
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
