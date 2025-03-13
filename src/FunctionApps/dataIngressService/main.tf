locals {
  environmentPrefix = var.environmentPrefix
  function_app_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-dataingressservice-func"
}

resource "azurerm_function_app" "function_app" {
  name                       = local.function_app_name
  location                   = var.environmentLocation
  resource_group_name        = var.backendservices_resource_group_name
  app_service_plan_id        = var.app_plan_backend_function_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  version                    = "~4"
  os_type                    = "linux"
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Michel Angrignon"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  site_config {
    #linux_fx_version = "DOCKER|wcpgovwus2acr.azurecr.io/dataingress-service:latest"
    always_on              = "true"
    vnet_route_all_enabled = "false"
    scm_type               = "VSTSRM"
    cors {
      allowed_origins     = ["*"]
      support_credentials = false
    }
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY      = var.appinsights_instrumentation_key
    BlobCacheExpirationTimeInMin        = 5
    BlobContainerFolder_ArchivedData    = "event-archive"
    BlobContainerFolder_PoisonData      = "poison-data"
    BlobContainerFolder_RawData         = "raw-data"
    BlobContainerName                   = "ingress-data"
    BlobStorageConnection               = var.storage_primary_connection_string
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
    DOCKER_REGISTRY_SERVER_URL          = var.acr_login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_username
    FUNCTIONS_WORKER_RUNTIME            = "dotnet"
    InputEventHubConnection             = var.eventhub_primary_connection_string_input
    InputEventHubName                   = "eventhub-ingressdata"
    KeyVaultName                        = var.key_vault_name
    RoleName                            = "DataIngressService"
    TsiEventHubConnection               = var.eventhub_primary_connection_string_tsi
    TsiEventHubName                     = "eventhub-sensordata-bulk"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = "true"
  }
}

# Integrate app with an Azure virtual network
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.backend_function_asp_subnet_id
}