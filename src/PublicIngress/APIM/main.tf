locals {
  environmentPrefix   = var.environmentPrefix
  apim_name           = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-management-apim"
  wildcard_operations = toset( ["GET", "DELETE", "OPTIONS", "POST", "PUT"]) 
}

resource "azurerm_api_management" "apim" {
  name                = local.apim_name
  location            = var.environmentLocation
  resource_group_name = var.public_ingress_resource_group_name
  publisher_name      = "Wenco"
  publisher_email     = "hpingli@wencomine.com"
  sku_name = var.EnvironmentSKU_Apim
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Anthony Hsu"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
# All API access subscription key for Automated Tests
resource "azurerm_api_management_subscription" "automated_test_subscription" {
  api_management_name = local.apim_name
  display_name        = "Automated Test Subscription"
  resource_group_name = var.public_ingress_resource_group_name
  state               = "active"
}

resource "azurerm_api_management_policy" "global_policy" {
  api_management_id = azurerm_api_management.apim.id
  xml_content =  replace(file("${path.module}/ApimGlobalPolicy.xml"),"AUTH0_TENANT_URL", var.auth0_tenant_url)
}