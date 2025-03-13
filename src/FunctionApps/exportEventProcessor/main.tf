locals {
  environmentPrefix = var.environmentPrefix
  function_app_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-exporteventprocessor-func"
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
    Owner       = "RSI Fusion"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  site_config {
    # linux_fx_version = "DOCKER|wcpgovwus2acr.azurecr.io/exporteventprocessor-service:latest"
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
    BatchSize                           = "5000"
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
    DOCKER_REGISTRY_SERVER_URL          = var.acr_login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_username
    ExportEventContainer                = "exporteventcontainer"
    FUNCTIONS_WORKER_RUNTIME            = "dotnet"
    KeyVaultName                        = var.key_vault_name    
    RoleName                            = "ExportEventProcessorService"
    ServiceBusConnectionString          = var.service_bus_primary_connection_string
    ServiceBusSubscriptionName          = "sbs-exporteventprocessor"
    ServiceBusTopicName                 = "sbt-export-command"
    StorageConnectionString             = var.storage_primary_connection_string
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = "true"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}

# Integrate app with an Azure virtual network
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.backend_function_asp_subnet_id
}

# # Add Diagnostic settings for FunctionApp
# resource "azurerm_monitor_diagnostic_setting" "function_diagnostic_name" {
#   name                       = "${local.function_app_name}-loganalytics"
#   target_resource_id         = azurerm_function_app.function_app.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   log {
#     category = "FunctionAppLogs"
#     enabled  = true

#     retention_policy {
#       enabled = true
#       days    = 30
#     }
#   }
# }