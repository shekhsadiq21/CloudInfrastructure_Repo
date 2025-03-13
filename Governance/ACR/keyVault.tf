
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                            = var.key_vault_name
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  enabled_for_disk_encryption     = false
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled        = false
  soft_delete_retention_days      = 7
  enabled_for_template_deployment = true

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

# Add Access policy for service connection 
resource "azurerm_key_vault_access_policy" "service_connection" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List",
    "Recover",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Recover",
    "Restore",
    "Backup",
    "Delete",
    "purge",
  ]
}


# acr secrets
resource "azurerm_key_vault_secret" "acr_login_server" {
  name         = "TF-OUT-ACR-LOGIN-SERVER"
  value        = azurerm_container_registry.acr.login_server
  content_type = "acr-credentials"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "acr_username" {
  name         = "TF-OUT-ACR-NAME"
  value        = azurerm_container_registry.acr.name
  content_type = "acr-credentials"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "TF-OUT-SECRET-ACR-ADMIN-PASSWORD"
  value        = azurerm_container_registry.acr.admin_password
  content_type = "acr-credentials"
  key_vault_id = azurerm_key_vault.keyvault.id
}
