resource "azurerm_key_vault_secret" "eventhub_secret" {
  name         = "EventHub-eventHubConnectionString"
  value        = var.eventhub_primary_connection_string
  content_type = "eventhub"
  key_vault_id = azurerm_key_vault.keyvault.id
}

#dlq
resource "azurerm_key_vault_secret" "eventhub_dlq_secret" {
  name         = "EventHub-dlqeventHubConnectionString"
  value        = var.eventhub_dlq_primary_connection_string
  content_type = "eventhub"
  key_vault_id = azurerm_key_vault.keyvault.id
}
