
output "public_storage_primary_connection_string" {
  value = azurerm_storage_account.storage_public.primary_connection_string
}

output "public_storage_account_name" {
  value = azurerm_storage_account.storage_public.name
}

output "public_storage_account_access_key" {
  value = azurerm_storage_account.storage_public.primary_access_key
}