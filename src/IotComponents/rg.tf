locals {
  iotcomponents_resource_group_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-iotcomponents-rg"
  environmentPrefix                 = var.environmentPrefix
}

# Deploy resource group
resource "azurerm_resource_group" "rg" {
  name     = local.iotcomponents_resource_group_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
