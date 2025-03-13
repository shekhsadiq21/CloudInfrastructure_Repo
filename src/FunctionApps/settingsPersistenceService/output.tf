
# access policy
output "settings_persistence_service_identity_id" {
  value = azurerm_function_app.function_app.identity.0.tenant_id
}

output "settings_persistence_service_principal_id" {
  value = azurerm_function_app.function_app.identity.0.principal_id
}

output "settings_persistence_base_url" {
  value = "https://${azurerm_function_app.function_app.default_hostname}"
}
