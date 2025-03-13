locals {
  environmentPrefix     = var.environmentPrefix
  service_bus_namespace = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-sbus"
}

#****************************************************
#      service bus namespace
#****************************************************

resource "azurerm_servicebus_namespace" "service_bus_namespace" {
  name                = local.service_bus_namespace
  location            = var.environmentLocation
  resource_group_name = var.shared_resource_group_name
  sku                 = "Standard"

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Teams"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"

  }
}

resource "azurerm_servicebus_topic" "eventmanagement_export" {
  name                = "sbt-export-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}


#*******************************************
#create topic for event management service event data
#*******************************************
resource "azurerm_servicebus_topic" "eventmanagement_eventdata" {
  name                = "sbt-eventmanagement-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}

#*******************************************
#create topic for event service event data
#*******************************************
resource "azurerm_servicebus_topic" "eventservice_eventdata" {
  name                = "sbt-eventservice-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}

resource "azurerm_servicebus_topic" "eventmanagement_siteevent" {
  name                = "sbt-siteevent"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name

  enable_partitioning = true
}

resource "azurerm_servicebus_topic" "email_command" {
  name                = "sbt-email-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}

resource "azurerm_servicebus_topic" "pdf_command" {
  name                = "sbt-pdf-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}

resource "azurerm_servicebus_topic" "virtualevent_testing_command" {
  name                = "sbt-virtualevent-testing-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  enable_partitioning = true
}

resource "azurerm_servicebus_subscription" "eventmanagement_sub_export" {
  name                = "sbs-exporteventprocessor"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.eventmanagement_export.name
  max_delivery_count  = 10
  requires_session    = true
}

#*******************************************
#create Servicebus Subscription for event management service event data
#*******************************************
resource "azurerm_servicebus_subscription" "eventmanagement_sub_eventdata" {
  name                = "sbs-eventmanagement-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.eventmanagement_eventdata.name
  max_delivery_count  = 10
  requires_session    = true
}

#*******************************************
#create Servicebus Subscription for event service event data
#*******************************************
resource "azurerm_servicebus_subscription" "eventservice_sub_eventdata" {
  name                = "sbs-eventservice-command"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.eventservice_eventdata.name
  max_delivery_count  = 10
  requires_session    = true
}

resource "azurerm_servicebus_subscription" "email_sub_command" {
  name                = "sbs-eventmanagement-email"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.email_command.name
  max_delivery_count  = 10
  requires_session    = false
}

resource "azurerm_servicebus_subscription" "pdf_sub_command" {
  name                = "sbs-eventmanagement-pdf"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.pdf_command.name
  max_delivery_count  = 10
  requires_session    = false
}

resource "azurerm_servicebus_subscription" "virtualevent_testing_sub_command" {
  name                = "sbs-eventmanagement-virtualevent_testing"
  resource_group_name = var.shared_resource_group_name
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace.name
  topic_name          = azurerm_servicebus_topic.virtualevent_testing_command.name
  max_delivery_count  = 10
  requires_session    = false
}