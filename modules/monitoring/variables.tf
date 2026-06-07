variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "application_insights_name" {
  type = string
}

variable "alert_rules" {
  type = list(object({
    name              = string
    target_resource_id = string
    description       = string
    severity          = number
    metric_namespace  = string
    metric_name       = string
    aggregation       = string
    operator          = string
    threshold         = number
  }))
  default = []
}

variable "diagnostic_settings" {
  type = list(object({
    name               = string
    target_resource_id = string
  }))
  default = []
}
