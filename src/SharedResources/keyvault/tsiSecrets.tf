resource "azurerm_key_vault_secret" "tsi_authority" {
  name         = "TSIApplicationConfiguration-AuthorityUrl"
  value        = "https://login.windows.net/"
  content_type = "TSI"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "tsi_isitgen" {
  name         = "TSIApplicationConfiguration-IsTSIGen2ON"
  value        = "true"
  content_type = "TSI"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "tsi_resourceurl" {
  name         = "TSIApplicationConfiguration-ResourceUrl"
  value        = "https://api.timeseries.azure.com/"
  content_type = "TSI"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "tsi_tenant_id" {
  name         = "TSIApplicationConfiguration-TenantId"
  value        = data.azurerm_client_config.current.tenant_id
  content_type = "TSI"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "tsi_fqdn" {
  name         = "TSIApplicationConfiguration-TSIEnvironmentFqdn"
  value        = var.tsi_data_access_fqdn
  content_type = "TSI"
  key_vault_id = azurerm_key_vault.keyvault.id
}