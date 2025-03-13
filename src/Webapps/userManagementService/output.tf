output "user_management_service_name" {
  value = azurerm_app_service.app_service_name.name
}

output "user_management_service_authority" {
  value = "https://${azurerm_app_service.app_service_name.default_site_hostname}"
}

# access policy
output "user_management_service_identity_id" {
  value = azurerm_app_service.app_service_name.identity.0.tenant_id
}

output "user_management_service_principal_id" {
  value = azurerm_app_service.app_service_name.identity.0.principal_id
}