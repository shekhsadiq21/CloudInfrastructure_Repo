locals {
  environmentPrefix = var.environmentPrefix
  postgresql_server_name   = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-postgresql"
}

# generate random password
resource "random_password" "postgresqlserver_password" {
  length           = 16
  special          = true
  override_special = "@#$%&"
}

resource "azurerm_postgresql_server" "postgresqlserver" {
  name                = local.postgresql_server_name
  location            = var.environmentLocation
  resource_group_name = var.backendservices_resource_group_name
  

  administrator_login          = "psqladmin"
  administrator_login_password = random_password.postgresqlserver_password.result

  sku_name   = var.postgresql_sku
  version    = var.postgresql_version
  storage_mb = var.postgresql_storage

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Anthony Hsu"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Alan Richards"
  }
}
# Fire wall rules
# Allow Authorization service subnet to talk with server
resource "azurerm_postgresql_firewall_rule" "allow_container_instance_subnet" {
  name                = "Allow_container_instance_subnet"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  start_ip_address    = "${var.EnvironmentNetClass}.${var.EnvironmentNet}.6.0"
  end_ip_address      = "${var.EnvironmentNetClass}.${var.EnvironmentNet}.6.254"
}
# whitelist wenco vpn
resource "azurerm_postgresql_firewall_rule" "wenco_vpn" {
  name                = "wenco_vpn"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  start_ip_address    = var.wenco_vpn_startip_address
  end_ip_address      = var.wenco_vpn_endip_address
}

# whitelist RSI vpn1
resource "azurerm_postgresql_firewall_rule" "rsi_vpn1" {
  name                = "rsi_vpn1"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  start_ip_address    = var.rsystems_vpn1_startip_address
  end_ip_address      = var.rsystems_vpn1_endip_address
}

# whitelist RSI vpn2
resource "azurerm_postgresql_firewall_rule" "rsi_vpn2" {
  name                = "rsi_vpn2"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  start_ip_address    = var.rsystems_vpn2_startip_address
  end_ip_address      = var.rsystems_vpn2_endip_address
}

# Allow_Azure_Services
resource "azurerm_postgresql_firewall_rule" "Allow_Azure_Services" {
  name                = "Allow_Azure_Services"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# Create database
resource "azurerm_postgresql_database" "authorization_db" {
  name                = "Authorization"
  resource_group_name = var.backendservices_resource_group_name
  server_name         = azurerm_postgresql_server.postgresqlserver.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}