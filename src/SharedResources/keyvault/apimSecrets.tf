# All API access subscription key for automated testing
resource "azurerm_key_vault_secret" "apim_testing_subscription_key" {
  name         = "Apim-testing-subscription-key"
  value        = var.apim_testing_subscription_key
  content_type = "apim"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "apim_gateway_url" {
  name         = "Apim-gateway-url"
  value        = var.apim_gateway_url
  content_type = "apim"
  key_vault_id = azurerm_key_vault.keyvault.id
}