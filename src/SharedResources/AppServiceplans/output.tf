# frontend app service plan ID
output "app_service_plan_frontend_id" {
  value = azurerm_app_service_plan.app_service_plan_frontend_name.id
}

# web app App servic plan ID
output "app_plan_backend_webapp_id" {
  value = azurerm_app_service_plan.app_plan_backend_webapp.id
}

# functionapp app service plan  ID
output "app_plan_backend_function_id" {
  value = azurerm_app_service_plan.app_plan_backend_function.id
}

# backend shared app service plan ID
output "app_plan_backend_services_shared_id" {
  value = azurerm_app_service_plan.app_plan_backend_services_shared.id
}
