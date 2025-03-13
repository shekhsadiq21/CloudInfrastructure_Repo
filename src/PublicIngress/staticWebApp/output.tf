output "static_frontend_name" {
  value = azurerm_static_site.static_web_app.name
}

output "static_frontend_authority" {
  value = "https://${azurerm_static_site.static_web_app.default_host_name}"
}

output "azurerm_template_deployment_static_frontend_id" {
  value = azurerm_resource_group_template_deployment.frontend_appsettings.id
}