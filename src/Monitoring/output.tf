output "monitoring_resource_group_name" {
  value = azurerm_resource_group.rg_monitoring.name
}

output "appinsights_instrumentation_key" {
  value     = azurerm_application_insights.application_insights.instrumentation_key
  sensitive = true
}

output "log_analytics_workspace_id" {
  value     = azurerm_log_analytics_workspace.log_analytics_workspace.id
  sensitive = true
}