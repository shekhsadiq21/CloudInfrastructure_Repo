locals {
  environmentPrefix         = var.environmentPrefix
  storage_account_public_name = "wcp${local.environmentPrefix}${var.location_environmentPrefix}publicst"
}

resource "azurerm_storage_account" "storage_public" {
  name                      = local.storage_account_public_name
  resource_group_name       = var.shared_resource_group_name
  location                  = var.environmentLocation
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  enable_https_traffic_only = true
  allow_blob_public_access  = true
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Michel Angrignon"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
    Purpose     = "Open to all netwroks"
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
}

#******************************************************
#           create storage containers
#******************************************************
resource "azurerm_storage_container" "static_assets" {
  name                  = "static-assets"
  storage_account_name  = azurerm_storage_account.storage_public.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "tenant" {
  name                  = "tenant"
  storage_account_name  = azurerm_storage_account.storage_public.name
  container_access_type = "container"
}