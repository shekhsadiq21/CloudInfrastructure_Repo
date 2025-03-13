# access policy
output "event_consumer_service_identity_id" {
  value = azurerm_function_app.function_app.identity.0.tenant_id
}

output "event_consumer_service_principal_id" {
  value = azurerm_function_app.function_app.identity.0.principal_id
}
