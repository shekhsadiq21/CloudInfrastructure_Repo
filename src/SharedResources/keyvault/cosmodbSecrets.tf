# cosmodb primary access key
resource "azurerm_key_vault_secret" "cosmo_db_primary_access_key" {
  name         = "CosmosDB-accountKey"
  value        = var.cosmo_db_primary_master_key
  content_type = "cosmo-db"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# cosmodb end point URL
resource "azurerm_key_vault_secret" "cosmo_db_endpoint" {
  name         = "CosmosDB-AccountEndpoint"
  value        = var.cosmodb_endpoint_url
  content_type = "cosmo-db"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# cosmodb db names

resource "azurerm_key_vault_secret" "cosmodb_main" {
  name         = "CosmosDB-database"
  value        = var.cosmodb_main_database_name
  content_type = "cosmo-db"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmodb_assetproductivity" {
  name         = "CosmosDB-AssetProductivityDatabase"
  value        = var.cosmodb_assetproductivity_database_name
  content_type = "cosmo-db"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# cosmo Ru 
resource "azurerm_key_vault_secret" "cosmodb_ru_units" {
  name         = "CosmosDB-requestUnits"
  value        = "400"
  content_type = "cosmo-db"
  key_vault_id = azurerm_key_vault.keyvault.id
}