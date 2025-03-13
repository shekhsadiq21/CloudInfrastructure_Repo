# cosmodb
output "cosmo_db_primary_master_key" {
  value = azurerm_cosmosdb_account.db.primary_master_key
}

output "cosmodb_endpoint_url" {
  value = azurerm_cosmosdb_account.db.endpoint
}

output "cosmodb_main_database_name" {
  value = azurerm_cosmosdb_sql_database.main.name
}

output "cosmodb_assetproductivity_database_name" {
  value = azurerm_cosmosdb_sql_database.AssetProductivity.name
}