locals {
  environmentPrefix = var.environmentPrefix
  azure_maps_name   = "wcp-${local.environmentPrefix}-global-maps"
}


resource "azurerm_maps_account" "map" {
  name                = local.azure_maps_name
  resource_group_name = var.shared_resource_group_name
  sku_name            = "S1"

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "FrontEnd Team"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}