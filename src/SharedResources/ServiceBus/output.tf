output "service_bus_primary_connection_string" {
  value = azurerm_servicebus_namespace.service_bus_namespace.default_primary_connection_string
}
