resource "azurerm_key_vault_secret" "azure_map_primary_connection_string" {
  name         = "AzureMapAuthenticationPrimarykey"
  value        = var.azuremap_primary_access_key
  content_type = "Azure Maps"
  key_vault_id = azurerm_key_vault.keyvault.id
}