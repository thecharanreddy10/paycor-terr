variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "backup_policies" {
  type = list(object({
    name = string
  }))
  default = []
}

variable "protected_vms" {
  type = list(object({
    name        = string
    vm_id       = string
    policy_name = string
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
  default = []
}
