resource "azurerm_key_vault_secret" "testing_frontend_username" {
  name         = "Testing-frontend-username"
  value        = "wencoadmin@wencomine.com"
  content_type = "Testing"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "testing_frontend_password" {
  name         = "Testing-frontend-password"
  value        = "password@123"
  content_type = "Testing"
  key_vault_id = azurerm_key_vault.keyvault.id
}
