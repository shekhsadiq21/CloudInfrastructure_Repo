output "certificate_service_url" {
  value = "https://${azurerm_app_service.app_service_name.default_site_hostname}"
}

# access policy
output "certificate_service_identity_id" {
  value = azurerm_app_service.app_service_name.identity.0.tenant_id
}

output "certificate_service_principal_id" {
  value = azurerm_app_service.app_service_name.identity.0.principal_id
}
