resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = { for diag in var.diagnostic_settings : diag.name => diag }

  name                       = each.value.name
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  dynamic "enabled_log" {
    for_each = each.value.log_categories
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
