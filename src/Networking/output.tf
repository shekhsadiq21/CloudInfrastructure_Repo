output "backend_webapps_asp_subnet_id" {
  value = azurerm_subnet.backend_webapps_asp_subnet_name.id
}

output "backend_shared_asp_subnet_id" {
  value = azurerm_subnet.backend_shared_asp_subnet_name.id
}

output "frontend_asp_subnet_id" {
  value = azurerm_subnet.frontend_asp_subnet_name.id
}

output "shared_resources_subnet_id" {
  value = azurerm_subnet.shared_subnet_name.id
}

output "iot_subnet_id" {
  value = azurerm_subnet.iot_subnet_name.id
}

output "backend_function_asp_subnet_id" {
  value = azurerm_subnet.backend_function_asp_subnet_name.id
}

output "customer_data_subnet_id" {
  value = azurerm_subnet.customer_data_subnet_name.id
}


output "network_profile_cis_id" {
  value = azurerm_network_profile.network_profile_cis.id
}