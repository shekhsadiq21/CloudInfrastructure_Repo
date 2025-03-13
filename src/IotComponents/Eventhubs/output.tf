output "eventhub_ingressdata_id" {
  value = azurerm_eventhub.eventhub_ingressdata.id
}

output "eventhub_eventdata_iothub_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_eventdata_iothub_rule.primary_connection_string
}


output "eventhub_telemetrydata_iothub_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_telemetrydata_iothub_rule.primary_connection_string
}


output "eventhub_sensordata_gen2_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_sensordata_gen2_rule.primary_connection_string
}

output "eventhub_sensordata_bulk_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_sensordata_bulk_rule.primary_connection_string
}

output "eventhub_msgcapture_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_msgcapture_rule.primary_connection_string
}

output "eventhub_ingressdata_rule" {
  value = azurerm_eventhub_authorization_rule.eventhub_ingressdata_rule.primary_connection_string
}

output "eventhub_primary_connection_string" {
  value = azurerm_eventhub_namespace.eventhubname.default_primary_connection_string
}

output "eventhub_dlq_primary_connection_string" {
  value = azurerm_eventhub_namespace.eventhubname-dlq.default_primary_connection_string
}

output "eventhub_namespace_resource_id" {
  value = azurerm_eventhub_namespace.eventhubname.id
}

output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.eventhubname.name
}