variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "server_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "administrator_login" {
  type = string
  default = "sqladminuser"
}

variable "administrator_login_password" {
  type = string
}
