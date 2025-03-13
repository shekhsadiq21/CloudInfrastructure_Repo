
locals {
  environmentPrefix         = var.environmentPrefix
  cosmodb_account_name      = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-account-cosmodb"
  db_AssetProductivity_name = "AssetProductivity"
  db_main_name              = "Main"
}

resource "azurerm_cosmosdb_account" "db" {
  name                              = local.cosmodb_account_name
  location                          = var.environmentLocation
  resource_group_name               = var.shared_resource_group_name
  public_network_access_enabled     = "true" # Whether or not public network access is allowed for this CosmosDB account.
  is_virtual_network_filter_enabled = "true"
  ip_range_filter                   = "${var.wenco_vpn_ipaddress},${var.rsystems_vpn1_ipaddress},${var.rsystems_vpn2_ipaddress},104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"
  # Accept connections from within public Azure datacenters" = [104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26]
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Teams"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }
  geo_location {
    location          = var.environmentLocation
    failover_priority = 0
  }
  virtual_network_rule {
    id = var.shared_resources_subnet_id
  }
  virtual_network_rule {
    id = var.frontend_asp_subnet_id
  }
  virtual_network_rule {
    id = var.backend_shared_asp_subnet_id
  }
  virtual_network_rule {
    id = var.backend_webapps_asp_subnet_id
  }
  virtual_network_rule {
    id = var.backend_function_asp_subnet_id
  }
}


#*******************************************
#create AssetProductivity database
#*******************************************
resource "azurerm_cosmosdb_sql_database" "AssetProductivity" {
  name                = local.db_AssetProductivity_name
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  throughput          = 1200
}
#*******************************************
#create main database
#*******************************************
resource "azurerm_cosmosdb_sql_database" "main" {
  name                = local.db_main_name
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  throughput          = 2300
}

#************************************************************************
# create containers for AssetProductivity database
#************************************************************************
resource "azurerm_cosmosdb_sql_container" "AssetProductivity_Asset" {
  name                = "Asset"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.AssetProductivity.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "AssetProductivity_AssetDailyProductivity" {
  name                = "AssetDailyProductivity"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.AssetProductivity.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "AssetProductivity_AssetUtilization" {
  name                = "AssetUtilization"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.AssetProductivity.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "AssetProductivity_DlqEvent" {
  name                = "DlqEvent"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.AssetProductivity.name
  partition_key_path  = "/PartitionKey"
}

#************************************************************************
# create containers for main database
#************************************************************************
resource "azurerm_cosmosdb_sql_container" "ApplicationSetting" {
  name                = "ApplicationSetting"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Asset_main" {
  name                = "Asset"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "AssetModel" {
  name                = "AssetModel"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "AssetSchedule" {
  name                = "AssetSchedule"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "VirtualEventSetting" {
  name                = "VirtualEventSetting"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "AssetType" {
  name                = "AssetType"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Event" {
  name                = "Event"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Fleet" {
  name                = "Fleet"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Location" {
  name                = "Location"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Organization" {
  name                = "Organization"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "Protocol" {
  name                = "Protocol"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "ProtocolAlarm" {
  name                = "ProtocolAlarm"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "ReportStatus" {
  name                = "ReportStatus"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Site" {
  name                = "Site"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Manufacturer" {
  name                = "Manufacturer"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"

}

resource "azurerm_cosmosdb_sql_container" "Owner" {
  name                = "Owner"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "ProtocolSensor" {
  name                = "ProtocolSensor"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "EmailDetail" {
  name                = "EmailDetail"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "User" {
  name                = "User"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "TelemetryTransformationRules" {
  name                = "TelemetryTransformationRules"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "Tenant" {
  name                = "Tenant"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "VirtualEvent" {
  name                = "VirtualEvent"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "Workspace" {
  name                = "Workspace"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "PasswordRecoveryLog" {
  name                = "PasswordRecoveryLog"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}

resource "azurerm_cosmosdb_sql_container" "DlqEvent_main" {
  name                = "DlqEvent"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/PartitionKey"
}