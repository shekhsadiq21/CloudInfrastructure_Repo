# generate random password for SPICEDB_GRPC_PRESHARED_KEY
resource "random_password" "spicedb_preshared_key" {
  length           = 16
  special          = true
  override_special = "@#$%&"
}

resource "azurerm_key_vault_secret" "spicedb_preshared_key" {
  name         = "SPICEDB-GRPC-PRESHARED-KEY"
  value        = random_password.spicedb_preshared_key.result
  content_type = "SpiceDB"
  key_vault_id = azurerm_key_vault.keyvault.id
}
# postgresql server database connection string
resource "azurerm_key_vault_secret" "postgresql_authorization_db_cs" {
  name         = "SPICEDB-DATASTORE-CONN-URI"
  value        = "postgres://${var.postgresql_server_admin_username}:${urlencode(var.postgresql_server_password)}@${var.postgresql_server_fqdn}:5432/${var.postgresql_db_name}"
  content_type = "Postgresql"
  key_vault_id = azurerm_key_vault.keyvault.id
}