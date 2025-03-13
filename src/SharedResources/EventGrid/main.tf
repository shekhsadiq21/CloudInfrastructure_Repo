locals {
  environmentPrefix              = var.environmentPrefix
  data_ingress_system_topic_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-data-ingress-egst"
}

# Data ingress event grid system topic
resource "azurerm_eventgrid_system_topic" "data_ingress" {
  name                   = local.data_ingress_system_topic_name
  resource_group_name    = var.shared_resource_group_name
  location               = var.environmentLocation
  source_arm_resource_id = var.storage_id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Michel Angrignon"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

# Data ingress event grid system topic event subscription
resource "azurerm_eventgrid_system_topic_event_subscription" "data_ingress" {
  name                  = "eventsubscription-ingressdata"
  system_topic          = local.data_ingress_system_topic_name
  resource_group_name   = var.shared_resource_group_name
  event_delivery_schema = "EventGridSchema"
  eventhub_endpoint_id  = var.eventhub_ingressdata_id

  included_event_types = ["Microsoft.Storage.BlobCreated"]
  advanced_filtering_on_arrays_enabled = true
  
  subject_filter {
    subject_begins_with = "/blobServices/default/containers/ingress-data/blobs/raw-data/"
    subject_ends_with = ".xz"
    case_sensitive = false
  }
}