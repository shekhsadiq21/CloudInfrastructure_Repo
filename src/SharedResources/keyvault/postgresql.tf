# postgresql credentials
resource "azurerm_key_vault_secret" "postgresql_username" {
  name         = "postgreqlserver-username"
  value        = var.postgresql_server_admin_login
  content_type = "postgresql"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "postgresql_password" {
  name         = "postgresqlserver-password"
  value        = var.postgresql_server_password
  content_type = "postgresql"
  key_vault_id = azurerm_key_vault.keyvault.id
}