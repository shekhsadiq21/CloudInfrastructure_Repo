
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                            = local.rg_dns_kv_name
  location                        = azurerm_resource_group.rg_dns.location
  resource_group_name             = azurerm_resource_group.rg_dns.name
  enabled_for_disk_encryption     = false
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled        = false
  soft_delete_retention_days      = 7
  enabled_for_template_deployment = true

  sku_name = "standard"

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["104.251.102.229/32"]
    virtual_network_subnet_ids = [var.shared_subnet_id]
  }
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}