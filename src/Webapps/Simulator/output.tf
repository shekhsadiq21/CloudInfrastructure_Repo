# access policy
output "gps_simulator_identity_id" {
  value = azurerm_app_service.app_service_name.identity.0.tenant_id
}

output "gps_simulator_principal_id" {
  value = azurerm_app_service.app_service_name.identity.0.principal_id
}
