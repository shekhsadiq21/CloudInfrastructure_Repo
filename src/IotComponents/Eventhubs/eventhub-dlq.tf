
#******************************************************
#      create a event hub namespace-dlq 
#******************************************************
resource "azurerm_eventhub_namespace" "eventhubname-dlq" {
  name                = local.eventhub_namespace_dlq
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
#      Create a event hubs for dlq
#******************************************************
resource "azurerm_eventhub" "eventhub_assetstate_dlq" {
  name                = "eventhub-assetstate-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_assetstate_dlq_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub-adminservice-dlq"
resource "azurerm_eventhub" "eventhub_adminservice_dlq" {
  name                = "eventhub-adminservice-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_adminservice_dlq_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_adminservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub-telemetryservice-dlq"
resource "azurerm_eventhub" "eventhub_telemetryservice_dlq" {
  name                = "eventhub-telemetryservice-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_telemetryservice_dlq_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetryservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub_eventconsumerservice_dlq"
resource "azurerm_eventhub" "eventhub_eventconsumerservice_dlq" {
  name                = "eventhub-eventconsumerservice-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_eventconsumerservice_dlq_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_eventconsumerservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub_eventmanagementservice_dlq"
resource "azurerm_eventhub" "eventhub_eventmanagementservice_dlq" {
  name                = "eventhub-eventmanagementservice-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "eventhub_eventmanagementservice_dlq_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_eventmanagementservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

# create "eventhub-tsi-migration"
resource "azurerm_eventhub" "eventhub-tsi-migration" {
  name                = "eventhub-tsi-migration"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  partition_count     = 5
  message_retention   = 7
}
resource "azurerm_eventhub_authorization_rule" "eventhub-tsi-migration_rule" {
  name                = "Eventhub-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub-tsi-migration.name
  resource_group_name = var.iotcomponents_resource_group_name
  listen              = true
  send                = true
  manage              = false
}

#************************************
#    create  consumer groups
#************************************
resource "azurerm_eventhub_consumer_group" "cg_assetproductivity_service_dlq" {
  name                = "cg-assetproductivity-service-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_assetstate_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_administration_service_dlq" {
  name                = "cg-administration-service-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_adminservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_telemetry_service_dlq" {
  name                = "cg-telemetry-service-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetryservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_eventconsumer_service_dlq" {
  name                = "cg-eventconsumer-service-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_eventconsumerservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}

resource "azurerm_eventhub_consumer_group" "cg_eventmanagement_service_dlq" {
  name                = "cg-eventmanagement-service-dlq"
  namespace_name      = azurerm_eventhub_namespace.eventhubname-dlq.name
  eventhub_name       = azurerm_eventhub.eventhub_eventmanagementservice_dlq.name
  resource_group_name = var.iotcomponents_resource_group_name
  user_metadata       = "some-meta-data"
}