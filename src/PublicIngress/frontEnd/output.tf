output "front_end_name" {
  value = azurerm_app_service.app_service_name.name
}

output "front_end_authority" {
  value = "https://${azurerm_app_service.app_service_name.default_site_hostname}"
}
output "frontendwebapp_AzureDomain" {
  value = azurerm_app_service.app_service_name.default_site_hostname
}