#******************************************************
#      create  event hub namespace 
#******************************************************
resource "azurerm_eventhub_namespace" "eventhubname" {
  name                = local.eventhub_namespace
  location            = var.environmentLocation
  resource_group_name = var.iotcomponents_resource_group_name
  sku                 = "Standard"
  capacity            = 1
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  network_rulesets = [
    {
      default_action = "Allow"
      ip_rule = [
        {
          action  = "Allow"
          ip_mask = var.rsystems_vpn1_ipaddress
        },
        {
          action  = "Allow"
          ip_mask = var.rsystems_vpn2_ipaddress
        },
        {
          action  = "Allow"
          ip_mask = var.wenco_vpn_ipaddress
        },
      ]
      trusted_service_access_enabled = true
      virtual_network_rule = [
        {
          subnet_id                                       = var.iot_subnet_id
          ignore_missing_virtual_network_service_endpoint = false
        },
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = var.frontend_asp_subnet_id
        },
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = var.backend_shared_asp_subnet_id
        },
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = var.backend_webapps_asp_subnet_id
        },
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = var.backend_function_asp_subnet_id
        },
        {
          ignore_missing_virtual_network_service_endpoint = false
          subnet_id                                       = var.shared_resources_subnet_id
        },
      ]
    },
  ]
}

#******************************************************
#   create  Eventhubs 
#******************************************************
resource "azurerm_eventhub" "eventhub_telemetrydata_iothub" {
  name                = "eventhub-telemetrydata-iothub"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 5
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_telemetrydata_iothub_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetrydata_iothub.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create   "eventhub_telemetry_enrich"
resource "azurerm_eventhub" "eventhub_telemetry_enrich" {
  name                = "eventhub-telemetry-enrich"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 5
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_telemetry_enrich_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry_enrich.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_eventdata_iothub"
resource "azurerm_eventhub" "eventhub_eventdata_iothub" {
  name                = "eventhub-eventdata-iothub"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_eventdata_iothub_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_eventdata_iothub.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_twinchangeevent"
resource "azurerm_eventhub" "eventhub_twinchangeevent" {
  name                = "eventhub-twinchangeevent"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_twinchangeevent_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_twinchangeevent.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_assetstate"
resource "azurerm_eventhub" "eventhub_assetstate" {
  name                = "eventhub-assetstate"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_assetstate_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_sensordata_gen2"
resource "azurerm_eventhub" "eventhub_sensordata_gen2" {
  name                = "eventhub-sensordata-gen2"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_sensordata_gen2_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_sensordata_gen2.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_sensordata_bulk"
resource "azurerm_eventhub" "eventhub_sensordata_bulk" {
  name                = "eventhub-sensordata-bulk"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_sensordata_bulk_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_sensordata_bulk.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub-msgcapture"
resource "azurerm_eventhub" "eventhub_msgcapture" {
  name                = "eventhub-msgcapture"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_msgcapture_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_msgcapture.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create  "eventhub_ingressdata"
resource "azurerm_eventhub" "eventhub_ingressdata" {
  name                = "eventhub-ingressdata"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_ingressdata_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_ingressdata.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = false
  manage              = false
}

#************************************
#    create  consumer groups
#************************************
resource "azurerm_eventhub_consumer_group" "cg_func_TelemetryConsumer" {
  name                = "cg-func-TelemetryConsumer"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetrydata_iothub.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_app_assetproductivity" {
  name                = "cg-app-assetproductivity"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry_enrich.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}
resource "azurerm_eventhub_consumer_group" "cg_func_eventconsumer" {
  name                = "cg-func-eventconsumer"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_eventdata_iothub.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}
resource "azurerm_eventhub_consumer_group" "cg_app_twinchangeeventconsumer" {
  name                = "cg-app-twinchangeeventconsumer"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_twinchangeevent.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_administration_service" {
  name                = "cg-administration-service"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}
resource "azurerm_eventhub_consumer_group" "cg_assetproductivity_service" {
  name                = "cg-assetproductivity-service"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}
resource "azurerm_eventhub_consumer_group" "cg_telemetry_consumer-service" {
  name                = "cg-telemetry-consumer-service"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}
resource "azurerm_eventhub_consumer_group" "cg_msgcapture" {
  name                = "cg-msgcapture"
  namespace_name      = azurerm_eventhub_namespace.eventhubname.name
  eventhub_name       = azurerm_eventhub.eventhub_msgcapture.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}