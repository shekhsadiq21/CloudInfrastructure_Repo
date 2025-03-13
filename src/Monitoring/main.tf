
locals {
  environmentPrefix            = var.environmentPrefix
  rg_monitoring_name           = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-monitoring-rg"
  log_analytics_workspace_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-workspace-log"
  application_insights_name    = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-application-appi"
}

# Deploy resource group
resource "azurerm_resource_group" "rg_monitoring" {
  name     = local.rg_monitoring_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Cloud Leads"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}