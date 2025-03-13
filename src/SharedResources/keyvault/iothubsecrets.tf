resource "azurerm_key_vault_secret" "iothub_fullaccess_pcs" {
  name         = "IotHub-iotHubConnectionString"
  value        = var.iothub_fullaccess_policy_primary_connection_string
  content_type = "iothub"
  key_vault_id = azurerm_key_vault.keyvault.id
}
