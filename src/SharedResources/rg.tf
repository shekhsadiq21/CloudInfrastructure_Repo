locals {
  shared_resource_group_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-sharedinfrastructure-rg"
  environmentPrefix          = var.environmentPrefix
}

# Deploy resource group
resource "azurerm_resource_group" "rg_shared" {
  name     = local.shared_resource_group_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
