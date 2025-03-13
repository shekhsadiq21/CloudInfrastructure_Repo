output "sql_server_password" {
  value = random_password.sqlserver_password.result
}

output "sql_server_admin_login" {
  value = "wencocloud"
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = azurerm_sql_server.sqlserver.fully_qualified_domain_name
}

output "db_name_asset_association_service" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.AssetAssociationService.name
}

output "db_name_company_service" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.CompanyService.name
}

output "db_name_device_inventory" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.DeviceInventory.name
}

output "db_name_event_management" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.EventManagement.name
}

output "db_name_event_service" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.EventService.name
}

output "db_name_asset_service" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.AssetService.name
}

output "db_name_user_service" {
  description = "Database name of the Azure SQL Database created."
  value       = azurerm_sql_database.UserService.name
}
