
locals {
  environmentPrefix         = var.environmentPrefix
  storage_account_main_name = "wcp${local.environmentPrefix}${var.location_environmentPrefix}mainst"
}


#*****************************************
#create a storage account
#*****************************************
data "azurerm_client_config" "current" {}
resource "azurerm_storage_account" "storage" {
  name                      = local.storage_account_main_name
  resource_group_name       = var.shared_resource_group_name
  location                  = var.environmentLocation
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  enable_https_traffic_only = true
  allow_blob_public_access  = true
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Teams"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  blob_properties {
    cors_rule {
      allowed_origins    = ["*"]
      allowed_methods    = ["GET", "OPTIONS"]
      allowed_headers    = [""]
      exposed_headers    = [""]
      max_age_in_seconds = "200"
    }
  }
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    # subnet will need to have Microsoft.Storage in its service_endpoint input variable
    ip_rules                   = [var.wenco_vpn_startip_address, var.rsystems_vpn1_ipaddress, var.rsystems_vpn2_ipaddress]
    virtual_network_subnet_ids = [var.shared_resources_subnet_id, var.frontend_asp_subnet_id, var.backend_shared_asp_subnet_id, var.backend_webapps_asp_subnet_id, var.backend_function_asp_subnet_id, var.customer_data_subnet_id]

  private_link_access {
    endpoint_resource_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.iotcomponents_resource_group_name}/providers/Microsoft.Devices/IotHubs/${var.azurerm_iothub_name}"
    endpoint_tenant_id   = data.azurerm_client_config.current.tenant_id
    }
  }
}

#******************************************************
#           create storage blobs
#******************************************************

resource "azurerm_storage_blob" "remote_config_blob" {
  name                   = "config.json"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.allocation_function.name
  type                   = "Block"
  source_content         = "{\"US\": \"${var.azurerm_iothub_hostname}\" }"
}

#******************************************************
#           create a storage containers 
#******************************************************
resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "admin_api_logs" {
  name                  = "admin-api-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "assetproductivity_api_logs" {
  name                  = "assetproductivity-api-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "azure_function_consumerservice_logs" {
  name                  = "azure-function-consumerservice-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "azure_webjobs_eventhub" {
  name                  = "azure-webjobs-eventhub"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "azure_webjobs_hosts" {
  name                  = "azure-webjobs-hosts"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "azure_webjobs_secrets" {
  name                  = "azure-webjobs-secrets"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "email_api_logs" {
  name                  = "email-api-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "icons" {
  name                  = "icons"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "pdf_api_reports" {
  name                  = "pdf-api-reports"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "pdfgenerator_api_logs" {
  name                  = "pdfgenerator-api-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "simulator_logs" {
  name                  = "simulator-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "telemetry_long_term_storage" {
  name                  = "telemetry-long-term-storage"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "tenant" {
  name                  = "tenant"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "usermanagement_api_logs" {
  name                  = "usermanagement-api-logs"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "pdf_service_eventhub_consumergroup" {
  name                  = "pdf-service-eventhub-consumergroup"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "email_service_eventhub_consumergroup" {
  name                  = "email-service-eventhub-consumergroup"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "virtual_builder" {
  name                  = "virtual-builder"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "virtual_event_metadata" {
  name                  = "virtual-event-metadata"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container-21" {
  name                  = "protocol-metadata"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container-22" {
  name                  = "administration-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container-23" {
  name                  = "assetstatus-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
resource "azurerm_storage_container" "container-231" {
  name                  = "assetproductivity-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container-24" {
  name                  = "pdf-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container-25" {
  name                  = "email-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "telemetry_consumer_service_eventhub_consumergroup_dlq" {
  name                  = "telemetry-consumer-service-eventhub-consumergroup-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "allocation_function" {
  name                  = "allocation-function"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "cg_eventmanagement_service_eventhub_dlq" {
  name                  = "cg-eventmanagement-service-dlq"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "iot_hub_container" {
  name                  = "iot-hub-messages"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "ingress-data" {
  name                  = "ingress-data"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# containers for CDN
resource "azurerm_storage_container" "static_assets" {
  name                  = "static-assets"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "dark_theme" {
  name                  = "dark-theme"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "light_theme" {
  name                  = "light-theme"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "export_event_container" {
  name                  = "exporteventcontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "story_book" {
  name                  = "story-book"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}