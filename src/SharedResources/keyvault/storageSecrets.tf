#Captcha
resource "azurerm_key_vault_secret" "Captcha_url" {
  name         = "Captcha-URL"
  value        = "https://www.google.com/recaptcha/api/siteverify?secret=6Le7v9EZAAAAAPhEgsF9ibJnQypbkjCXgN1ioq_P&response={0}"
  content_type = "Captcha"
  key_vault_id = azurerm_key_vault.keyvault.id
}


# Storage account blob base URL
resource "azurerm_key_vault_secret" "storage_blob_base_url" {
  name         = "StorageAccount-storageBaseUrl"
  value        = "https://${var.storage_account_name}.blob.core.windows.net"
  content_type = "Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}


# Storage account connection string
resource "azurerm_key_vault_secret" "storage_account_secert" {
  name         = "StorageAccount-storageConnectionString"
  value        = var.storage_primary_connection_string
  content_type = "Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "storage_queue_secret" {
  name         = "StorageQueue-storageConnectionString"
  value        = var.storage_primary_connection_string
  content_type = "Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "logging_storage_secret" {
  name         = "Logging-storageConnectionString"
  value        = var.storage_primary_connection_string
  content_type = "Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "event_storage_secret" {
  name         = "EventHub-eventHubStorageConnectionString"
  value        = var.storage_primary_connection_string
  content_type = "Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Public Storage account blob base URL
resource "azurerm_key_vault_secret" "public_storage_blob_base_url" {
  name         = "StorageAccount-publicStorageBaseUrl"
  value        = "https://${var.public_storage_account_name}.blob.core.windows.net"
  content_type = "Public Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}

#Public storage
# Public Storage account connection string
resource "azurerm_key_vault_secret" "public_storage_account_secret" {
  name         = "StorageAccount-publicStorageConnectionString"
  value        = var.public_storage_primary_connection_string
  content_type = "Public Storage Account"
  key_vault_id = azurerm_key_vault.keyvault.id
}