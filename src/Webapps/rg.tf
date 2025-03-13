locals {
  backendservices_resource_group_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backendservices-rg"
  environmentPrefix                   = var.environmentPrefix
}

# Deploy resource group
resource "azurerm_resource_group" "rg_shared" {
  name     = local.backendservices_resource_group_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Alan Richards"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
