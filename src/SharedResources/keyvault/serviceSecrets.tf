# admin
resource "azurerm_key_vault_secret" "admin_url" {
  name         = "ServiceUrls-adminServiceUrl"
  value        = var.admin_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# asset association service
resource "azurerm_key_vault_secret" "asset_association_service_url" {
  name         = "ServiceUrls-assetAssociationServiceUrl"
  value        = var.asset_association_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}


# asset productivity
resource "azurerm_key_vault_secret" "asset_productivity_url" {
  name         = "ServiceUrls-assetProductivityServiceUrl"
  value        = var.asset_productivity_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# company service
resource "azurerm_key_vault_secret" "company_service_url" {
  name         = "ServiceUrls-companyServiceUrl"
  value        = var.company_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}


# device inventory
resource "azurerm_key_vault_secret" "device_url" {
  name         = "ServiceUrls-deviceInventoryServiceUrl"
  value        = var.device_inventory_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# email
resource "azurerm_key_vault_secret" "email_url" {
  name         = "ServiceUrls-emailServiceUrl"
  value        = var.email_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# event management
resource "azurerm_key_vault_secret" "event_url" {
  name         = "ServiceUrls-eventManagementServiceUrl"
  value        = var.event_management_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# event service
resource "azurerm_key_vault_secret" "event_service_url" {
  name         = "ServiceUrls-eventServiceUrl"
  value        = var.event_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# asset service
resource "azurerm_key_vault_secret" "asset_service_url" {
  name         = "ServiceUrls-assetServiceUrl"
  value        = var.asset_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# user service
resource "azurerm_key_vault_secret" "user_service_url" {
  name         = "ServiceUrls-userServiceUrl"
  value        = var.user_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# pdf
resource "azurerm_key_vault_secret" "pdf_url" {
  name         = "ServiceUrls-pdfGeneratorServiceUrl"
  value        = var.pdf_service_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# user management
resource "azurerm_key_vault_secret" "user_url" {
  name         = "ServiceUrls-userManagementServiceUrl"
  value        = var.user_management_service_authority
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Persistence Service
resource "azurerm_key_vault_secret" "persistence_url" {
  name         = "ServiceUrls-settingPersistenceServiceUrl"
  value        = var.settings_persistence_base_url
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# identity uri
resource "azurerm_key_vault_secret" "identity_url" {
  name         = "ServiceUrls-identityServiceUrl"
  value        = "${var.user_management_service_authority}/v1/"
  content_type = "Service-urls"
  key_vault_id = azurerm_key_vault.keyvault.id
}