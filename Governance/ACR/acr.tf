#**************************************************************
#          create resource group
#**************************************************************
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
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

#**************************************************************
#          create container registry
#**************************************************************

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Harshith Pingili"
    Requester   = "Martin Politick"
    CostCenter  = "HCM-ReadyLine-${var.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
