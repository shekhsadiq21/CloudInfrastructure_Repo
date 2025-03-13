output "apim_name" {
  value = azurerm_api_management.apim.name
}

output "apim_gateway_url" {
  value = azurerm_api_management.apim.gateway_url
}

output "apim_testing_subscription_key" {
  value = azurerm_api_management_subscription.automated_test_subscription.primary_key
}