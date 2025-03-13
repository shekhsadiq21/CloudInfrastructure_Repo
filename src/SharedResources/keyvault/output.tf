# key vault name
output "key_vault_name" {
  value = azurerm_key_vault.keyvault.name
}

output "SqlDB_EventManagementConnectionString" {
  value = azurerm_key_vault_secret.sql_db_event_management_cs.value
}

output "spicedb_preshared_key" {
  value = azurerm_key_vault_secret.spicedb_preshared_key.value
}

output "postgresql_authorization_db_cs" {
  value = azurerm_key_vault_secret.postgresql_authorization_db_cs.value
}