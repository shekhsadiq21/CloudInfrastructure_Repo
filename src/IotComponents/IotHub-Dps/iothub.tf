#*****************************************************
#               IOT hub 
#****************************************************
resource "azurerm_iothub" "IOTHUB" {
  name                = local.iothub_name
  resource_group_name = var.iotcomponents_resource_group_name
  location            = var.environmentLocation
  public_network_access_enabled = "true"
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }
  identity {
    type = "SystemAssigned"
  }
  # Endpoints
  endpoint {
    type                = "AzureIotHub.EventHub"
    connection_string   = var.eventhub_telemetrydata_iothub_rule
    name                = "eventhub-telemetry"
    resource_group_name = var.iotcomponents_resource_group_name
  }
  endpoint {
    type                = "AzureIotHub.EventHub"
    connection_string   = var.eventhub_eventdata_iothub_rule
    name                = "wenco-eventconsumer"
    resource_group_name = var.iotcomponents_resource_group_name
  }
  endpoint {
    type                = "AzureIotHub.EventHub"
    connection_string   = var.eventhub_sensordata_gen2_rule
    name                = "tsi-gen2"
    resource_group_name = var.iotcomponents_resource_group_name
  }
  endpoint {
    type                = "AzureIotHub.EventHub"
    connection_string   = var.eventhub_msgcapture_rule
    name                = "msgcapture"
    resource_group_name = var.iotcomponents_resource_group_name
  }

  #Send data from devices to endpoints  
  route {
    name           = "wenco-defaultroute"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["events"]
    enabled        = true
  }
  route {
    name           = "tsi-event-route-2"
    source         = "DeviceMessages"
    condition      = "wencoMessageType='sensorData'"
    endpoint_names = ["tsi-gen2"]
    enabled        = true
  }
  route {
    name           = "eventhub-telemetry"
    source         = "DeviceMessages"
    condition      = "wencoMessageType='sensorData'"
    endpoint_names = ["eventhub-telemetry"]
    enabled        = true
  }
  route {
    name           = "msgcapture"
    source         = "DeviceMessages"
    condition      = "wencoMessageType='msgCapture'"
    endpoint_names = ["msgcapture"]
    enabled        = true
  }
  route {
    name           = "wenco-eventconsumer"
    source         = "DeviceMessages"
    condition      = "wencoMessageType='eventData'"
    endpoint_names = ["wenco-eventconsumer"]
    enabled        = true
  }


  # fall back routes
  fallback_route {
    source         = "DeviceMessages"
    endpoint_names = ["events"]
    enabled        = true
  }
}

resource "null_resource" "wenco-simulator" {

  provisioner "local-exec" {
    command = <<-EOT
      az iot hub device-identity create --device-id wenco-simulator --hub-name ${local.iothub_name}
    EOT
  }
}

resource "null_resource" "FieldGateway" {

  provisioner "local-exec" {
    command = <<-EOT
      az iot hub device-identity create --device-id FieldGateway --hub-name ${local.iothub_name}
    EOT
  }
}


resource "null_resource" "tsi-wenco" {

  provisioner "local-exec" {
    command = <<-EOT
      az iot hub device-identity create --device-id tsi-wenco-${local.environmentPrefix} --hub-name ${local.iothub_name}

    EOT
  }
}


resource "null_resource" "WencoAutomatedTesting" {

  provisioner "local-exec" {
    command = <<-EOT
      az iot hub device-identity create --device-id WencoAutomatedTesting --hub-name ${local.iothub_name}
    EOT
  }
}