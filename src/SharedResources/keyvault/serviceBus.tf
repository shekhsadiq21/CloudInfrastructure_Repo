resource "azurerm_key_vault_secret" "service_bus_primary_connection_string" {
  name         = "ServiceBus-serviceBusConnectionString"
  value        = var.service_bus_primary_connection_string
  content_type = "ServiceBus"
  key_vault_id = azurerm_key_vault.keyvault.id
}