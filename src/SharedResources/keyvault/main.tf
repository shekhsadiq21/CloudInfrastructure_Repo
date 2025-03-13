locals {
  environmentPrefix = var.environmentPrefix
  key_vault_name    = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-sh-kv"
}

data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                            = local.key_vault_name
  location                        = var.environmentLocation
  resource_group_name             = var.shared_resource_group_name
  enabled_for_disk_encryption     = false
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled        = false
  enabled_for_template_deployment = true

  sku_name = "standard"

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices" 
    ip_rules                   = [var.wenco_vpn_ipaddress, var.rsystems_vpn1_ipaddress, var.azure_devops_ipaddress, var.rsystems_vpn2_ipaddress]
    virtual_network_subnet_ids = [var.shared_resources_subnet_id, var.frontend_asp_subnet_id, var.backend_shared_asp_subnet_id, var.backend_webapps_asp_subnet_id, var.backend_function_asp_subnet_id]
  }
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
