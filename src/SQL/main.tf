locals {
  environmentPrefix = var.environmentPrefix
  sql_server_name   = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-sql"
}

# generate random password
resource "random_password" "sqlserver_password" {
  length           = 16
  special          = true
  override_special = "@#$%&"
}

# CREATE SQL SERVER
resource "azurerm_sql_server" "sqlserver" {
  name                         = local.sql_server_name
  resource_group_name          = var.backendservices_resource_group_name
  location                     = var.environmentLocation
  version                      = "12.0"
  administrator_login          = "wencocloud"
  administrator_login_password = random_password.sqlserver_password.result
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Infrastructure"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
  threat_detection_policy {
    # disabled_alerts            = 
    # email_account_admins       = 
    # email_addresses            = 
    # retention_days             =
    state                      = "Disabled"
    # storage_account_access_key = 
    # storage_endpoint           = 
    }

}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  subnet_id           = var.shared_resources_subnet_id
}

resource "azurerm_sql_virtual_network_rule" "allow_backend_asp" {
  name                = "sql-vnet-allow-backendwebapps-subnet"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  subnet_id           = var.backend_webapps_asp_subnet_id
}

resource "azurerm_sql_firewall_rule" "firewallrule_rsi" {
  name                = "rsystems-vpn"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = var.rsystems_vpn1_startip_address
  end_ip_address      = var.rsystems_vpn1_endip_address
}

resource "azurerm_sql_firewall_rule" "firewallrule_rsi2" {
  name                = "rsystems-vpn2"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = var.rsystems_vpn2_startip_address
  end_ip_address      = var.rsystems_vpn2_endip_address
}
# Allow wenco vpn Ipaddress
resource "azurerm_sql_firewall_rule" "firewallrule_wenco" {
  name                = "wenco-vpn"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = var.wenco_vpn_startip_address
  end_ip_address      = var.wenco_vpn_endip_address
}
# Allow all azure services Ipaddress
resource "azurerm_sql_firewall_rule" "firewallrule_azure" {
  name                = "azure"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}


# create a asset association DB
resource "azurerm_sql_database" "AssetAssociationService" {
  name                             = "AssetAssociationDB"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.asset_association_service_sql_db_edition
  requested_service_objective_name = var.asset_association_service_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Marvels"
    Requester   = "Amit Kumar Thakur"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}

# create a company DB
resource "azurerm_sql_database" "CompanyService" {
  name                             = "CompanyDB"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.company_service_sql_db_edition
  requested_service_objective_name = var.company_service_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Marvels"
    Requester   = "Amit Kumar"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}


# create a DeviceInventory DB
resource "azurerm_sql_database" "DeviceInventory" {
  name                             = "DeviceInventory"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.device_inventory_sql_db_edition
  requested_service_objective_name = var.device_inventory_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Matrix"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}

# create a EventManagement DB
resource "azurerm_sql_database" "EventManagement" {
  name                             = "EventManagement"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.event_management_sql_db_edition
  requested_service_objective_name = var.event_management_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Matrix"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}

# create a Event DB
resource "azurerm_sql_database" "EventService" {
  name                             = "EventDB"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.event_service_sql_db_edition
  requested_service_objective_name = var.event_service_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Matrix"
    Requester   = "Deepak Agarwal"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}

# create a Asset DB
resource "azurerm_sql_database" "AssetService" {
  name                             = "AssetDB"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.asset_service_sql_db_edition
  requested_service_objective_name = var.asset_service_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Matrix"
    Requester   = "Niraj kumar"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}

# create a User DB
resource "azurerm_sql_database" "UserService" {
  name                             = "UserDB"
  resource_group_name              = var.backendservices_resource_group_name
  location                         = var.environmentLocation
  server_name                      = azurerm_sql_server.sqlserver.name
  create_mode                      = "Default"
  edition                          = var.user_service_sql_db_edition
  requested_service_objective_name = var.user_service_requested_service_objective_name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "RSI Matrix"
    Requester   = "Niraj kumar"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Infrastructure"
  }
}
