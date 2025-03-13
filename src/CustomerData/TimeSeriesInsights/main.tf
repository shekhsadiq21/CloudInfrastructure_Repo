locals {
  environmentPrefix                     = var.environmentPrefix
  time_series_insights_environment_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-gen2-tsi"
  tsi_eventsource_name                  = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-event-source-tsi"
}


#*****************************************************
# create a Time series Insights Environment Gen2
#*****************************************************
resource "azurerm_iot_time_series_insights_gen2_environment" "TimeSeries" {
  name                           = local.time_series_insights_environment_name
  location                       = var.environmentLocation
  resource_group_name            = var.user_data_resource_group_name
  sku_name                       = "L1"
  id_properties                  = ["siteId", "assetId", "telemetry.data.id"]
  warm_store_data_retention_time = "P7D"
  storage {
    name = var.public_storage_account_name
    key  = var.public_storage_account_access_key
  }
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}