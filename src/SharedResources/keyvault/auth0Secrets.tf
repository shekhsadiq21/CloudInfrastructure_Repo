resource "azurerm_key_vault_secret" "auth0_tenant_url" {
  name         = "Auth0-TenantUrl"
  value        = var.auth0_tenant_url
  content_type = "Auth0"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "auth0_automation_clientId" {
  name         = "Auth0-Automation-ClientId"
  value        = var.auth0_automation_clientId
  content_type = "Auth0"
  key_vault_id = azurerm_key_vault.keyvault.id
}