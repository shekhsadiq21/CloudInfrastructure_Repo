
locals {
  environmentPrefix = var.environmentPrefix
  app_service_name  = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-simulator-app"
}


# create a web app 
resource "azurerm_app_service" "app_service_name" {
  name                    = local.app_service_name
  location                = var.environmentLocation
  resource_group_name     = var.backendservices_resource_group_name
  app_service_plan_id     = var.app_plan_backend_services_shared_id
  https_only              = true
  client_affinity_enabled = true
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Fusion"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  site_config {
    #linux_fx_version = "DOCKER|wcpgovwus2acr.azurecr.io/gpssimulator-service:latest"
    always_on              = "true"
    scm_type               = "VSTSRM"
    vnet_route_all_enabled = "false"
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    ASPNETCORE_ENVIRONMENT                          = var.aspNet_environment
    KeyVaultName                                    = var.key_vault_name
    APPINSIGHTS_INSTRUMENTATIONKEY                  = var.appinsights_instrumentation_key
    DOCKER_REGISTRY_SERVER_URL                      = var.acr_login_server
    DOCKER_REGISTRY_SERVER_USERNAME                 = var.acr_username
    DOCKER_REGISTRY_SERVER_PASSWORD                 = var.acr_password    
    RoleName                                        = "SimulatorWebApp"    
  }
}

# Integrate app with an Azure virtual network
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_app_service.app_service_name.id
  subnet_id      = var.backend_shared_asp_subnet_id
}

# # Add Diagnostic setting for AppServiceConsoleLogs, AppServiceAppLogs
# resource "azurerm_monitor_diagnostic_setting" "appservice_diagnostic" {
#   name                       = "${local.app_service_name}-loganalytics"
#   target_resource_id         = azurerm_app_service.app_service_name.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id
#   log {
#     category = "AppServiceConsoleLogs"
#     enabled  = true

#     retention_policy {
#       enabled = true
#       days    = 30
#     }
#   }
#   log {
#     category = "AppServiceAppLogs"
#     enabled  = true

#     retention_policy {
#       enabled = true
#       days    = 30
#     }
#   }
# }