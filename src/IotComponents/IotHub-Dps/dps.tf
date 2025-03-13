# To link DPS to the created IoT Hub, we need an IoT Hub Access Policy
resource "azurerm_iothub_shared_access_policy" "iot_policy" {
  name                = "iothub-dps"
  resource_group_name = var.iotcomponents_resource_group_name
  iothub_name         = azurerm_iothub.IOTHUB.name

  registry_read  = true
  registry_write = true
}

# Deploy DPS
resource "azurerm_iothub_dps" "iot_dps" {
  name                = local.dps_name
  resource_group_name = var.iotcomponents_resource_group_name
  location            = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  sku {
    name     = "S1"
    capacity = "1"
  }

  linked_hub {
    connection_string       = azurerm_iothub_shared_access_policy.iot_policy.primary_connection_string
    location                = var.environmentLocation
    apply_allocation_policy = true
    allocation_weight       = 1
  }
}
