# Add Access policy for service connection 
resource "azurerm_key_vault_access_policy" "service_connection" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "create",
    "get",
    "list",
    "update",
  ]
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


# add keyvault access policy for administration service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_admin" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.administration_service_identity_id
  object_id    = var.administration_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for asset association service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_assetassociation" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.asset_association_service_identity_id
  object_id    = var.asset_association_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for asset productivity
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_assetproductivity" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.asset_productivity_service_identity_id
  object_id    = var.asset_productivity_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for certificate service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_certificate" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.certificate_service_identity_id
  object_id    = var.certificate_service_principal_id

  certificate_permissions = [
    "get",
    "list",
  ]
  key_permissions = [
    "Sign",
  ]
  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for company service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_company" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.company_service_identity_id
  object_id    = var.company_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}


# add keyvault access policy for device inventory service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_device" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.device_inventory_service_identity_id
  object_id    = var.device_inventory_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for gps simulator
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_simulator" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.gps_simulator_identity_id
  object_id    = var.gps_simulator_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for email service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_email" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.email_service_identity_id
  object_id    = var.email_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for event management service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_event" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.event_management_service_identity_id
  object_id    = var.event_management_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for event service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_eventservice" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.event_service_identity_id
  object_id    = var.event_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for asset service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_assetservice" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.asset_service_identity_id
  object_id    = var.asset_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for user service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_userservice" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.user_service_identity_id
  object_id    = var.user_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for data ingress service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_dataingress" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.data_ingress_service_identity_id
  object_id    = var.data_ingress_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for event consumer service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_eventconsumer" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.event_consumer_service_identity_id
  object_id    = var.event_consumer_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for export event processor service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_exporteventprocessor" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.export_event_processor_service_identity_id
  object_id    = var.export_event_processor_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for pdf service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_pdf" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.pdf_service_identity_id
  object_id    = var.pdf_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for settings persistence service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_presistence" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.settings_persistence_service_identity_id
  object_id    = var.settings_persistence_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# add keyvault access policy for user management service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_user_management" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.user_management_service_identity_id
  object_id    = var.user_management_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}


# add keyvault access policy for telemetry consumer service
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_telemetryconsumer" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.telemetry_consumer_service_identity_id
  object_id    = var.telemetry_consumer_service_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}


# add keyvault access policy for virtualexpressiondeploymentverification
resource "azurerm_key_vault_access_policy" "keyvault_access_policy_virtualexpressiondeploymentverification" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.virtualexpressiondeploymentverification_identity_id
  object_id    = var.virtualexpressiondeploymentverification_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}