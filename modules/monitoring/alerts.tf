resource "azurerm_monitor_metric_alert" "this" {
  for_each = { for alert in var.alert_rules : alert.name => alert }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = [each.value.target_resource_id]
  description         = each.value.description
  severity            = each.value.severity
  enabled             = true
  frequency           = "PT5M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }
}
