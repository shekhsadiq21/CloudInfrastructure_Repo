locals {
  environmentPrefix = var.environmentPrefix
  rg_dns_name       = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-dns-rg"
  rg_dns_kv_name    = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-dns-kv"
}

# Deploy resource group
resource "azurerm_resource_group" "rg_dns" {
  name     = local.rg_dns_name
  location = var.location
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
# create DNS zone for consite mine
resource "azurerm_dns_zone" "dns_consitemine" {
  name                = "consitemine.com"
  resource_group_name = azurerm_resource_group.rg_dns.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

#  create DNS zone for readylinebi
resource "azurerm_dns_zone" "dns_readylinebi" {
  name                = "readylinebi.com"
  resource_group_name = azurerm_resource_group.rg_dns.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

#  create DNS zone for wenco.io
resource "azurerm_dns_zone" "dns_wencoio" {
  name                = "wenco.io"
  resource_group_name = azurerm_resource_group.rg_dns.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Martin Politick"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}