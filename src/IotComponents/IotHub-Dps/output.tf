output "azurerm_iothub_hostname" {
  value = azurerm_iothub.IOTHUB.hostname
}
output "azurerm_iothub_name" {
  value = azurerm_iothub.IOTHUB.name
}
output "iothub_fullaccess_policy_primary_connection_string" {
  value = azurerm_iothub_shared_access_policy.full_accesspolicy.primary_connection_string
}

# access policy
output "iothub_identity_id" {
  value = azurerm_iothub.IOTHUB.identity.0.tenant_id
}

output "iothub_principal_id" {
  value = azurerm_iothub.IOTHUB.identity.0.principal_id
}