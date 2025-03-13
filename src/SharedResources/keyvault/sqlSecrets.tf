# key Vault secerts are defined 
# SQL credentials
resource "azurerm_key_vault_secret" "sql_username" {
  name         = "sqlserver-username"
  value        = "wencocloud"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sqlserver-password"
  value        = var.sql_server_password
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}


# assetAssociationService -db 
resource "azurerm_key_vault_secret" "sql_db_asset_association_service_cs" {
  name         = "SqlDB-AssetAssociationServiceConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_asset_association_service};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}
# companyService -db 
resource "azurerm_key_vault_secret" "sql_db_company_service_cs" {
  name         = "SqlDB-CompanyServiceConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_company_service};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}
# deviceInventory -db 
resource "azurerm_key_vault_secret" "sql_db_device_cs" {
  name         = "SqlDB-DeviceInventoryConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_device_inventory};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}
# EventManagement-db
resource "azurerm_key_vault_secret" "sql_db_event_management_cs" {
  name         = "SqlDB-EventManagementConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_event_management};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}
# EventService-db
resource "azurerm_key_vault_secret" "sql_db_event_service_cs" {
  name         = "SqlDB-EventServiceConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_event_service};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# AssetService-db
resource "azurerm_key_vault_secret" "sql_db_asset_service_cs" {
  name         = "SqlDB-AssetServiceConnectionString"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_asset_service};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# UserService-db
resource "azurerm_key_vault_secret" "sql_db_user_service_cs" {
  name         = "ConnectionStrings--UserManagementDatabase"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Initial Catalog=${var.db_name_user_service};Persist Security Info=False;User ID=${var.sql_server_admin_login};Password=${var.sql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  content_type = "sql-server"
  key_vault_id = azurerm_key_vault.keyvault.id
}
