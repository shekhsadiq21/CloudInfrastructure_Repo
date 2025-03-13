locals {
  environmentPrefix                = var.environmentPrefix
  rg_networking_name               = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-networking-rg"
  vnet_name                        = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-vnet"
  nsg_name                         = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-nsg"
  shared_subnet_name               = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-shared-snet"
}

# Deploy resource group
resource "azurerm_resource_group" "rg_networking" {
  name     = local.rg_networking_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# create network security group 
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = azurerm_resource_group.rg_networking.location
  resource_group_name = azurerm_resource_group.rg_networking.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# create Vnet
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg_networking.location
  resource_group_name = azurerm_resource_group.rg_networking.name
  address_space       = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.0.0/16"]
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# subnet
resource "azurerm_subnet" "shared_subnet_name" {
  name                 = local.shared_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.0.0/24"]
  service_endpoints    = ["Microsoft.KeyVault"]
}