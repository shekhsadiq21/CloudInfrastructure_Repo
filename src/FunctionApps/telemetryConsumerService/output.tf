# access policy
output "telemetry_consumer_service_identity_id" {
  value = azurerm_function_app.function_app.identity.0.tenant_id
}

output "telemetry_consumer_service_principal_id" {
  value = azurerm_function_app.function_app.identity.0.principal_id
}

