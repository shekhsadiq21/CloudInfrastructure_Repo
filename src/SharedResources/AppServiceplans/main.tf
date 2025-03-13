#Reference document: https://wencosupport.atlassian.net/wiki/spaces/WL/pages/4579360801/ReadyLine+App+Service+plan+deployment+plan for appServciePlans slots
locals {
  app_plan_backend_services_shared       = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-shared-asp"
  app_service_plan_backend_function_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-functions-asp"
  app_service_plan_backend_webapp_name   = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-webapps-asp"
  app_service_plan_frontend_name         = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-frontend-asp"
  environmentPrefix                      = var.environmentPrefix
}

#**************************************************************
#       create a Azure app service plan for frontend
#**************************************************************
resource "azurerm_app_service_plan" "app_service_plan_frontend_name" {
  name                = local.app_service_plan_frontend_name
  location            = var.environmentLocation
  resource_group_name = var.shared_resource_group_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
    Purpose     = "app service plan for frontend"
  }
  sku {
    tier = var.frontend_appserviceplan_tier
    size = var.frontend_appserviceplan_size
  }
}

resource "azurerm_app_service_plan" "app_plan_backend_webapp" {
  name                = local.app_service_plan_backend_webapp_name
  location            = var.environmentLocation
  resource_group_name = var.shared_resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.backend_webapp_appserviceplan_tier
    size = var.backend_webapp_appserviceplan_size
  }

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
    Purpose     = "Shared app service plan for backend web services"
  }

}


#**************************************************************
#       create a Azure app service plan for function services 
#       Telemetry consumer, Event consumer, Certification service
#       Device Allocation
#**************************************************************
resource "azurerm_app_service_plan" "app_plan_backend_function" {
  name                = local.app_service_plan_backend_function_name
  location            = var.environmentLocation
  resource_group_name = var.shared_resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.backend_function_appserviceplan_tier
    size = var.backend_function_appserviceplan_size
  }

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
    Purpose     = "Shared app service plan for backend function services"
  }

}

#**************************************************************
#       create a Azure app service plan for function services 
#      Virtual event tester, Pdf generator, simulator
#**************************************************************
resource "azurerm_app_service_plan" "app_plan_backend_services_shared" {
  name                = local.app_plan_backend_services_shared
  location            = var.environmentLocation
  resource_group_name = var.shared_resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.backend_services_shared_appserviceplan_tier
    size = var.backend_services_shared_appserviceplan_size
  }

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
    Purpose     = "shared app service plan for backend services"
  }

}