output "postgresql_server_password" {
  value = random_password.postgresqlserver_password.result
}

output "postgresql_server_admin_login" {
  value = "psqladmin"
}

output "postgresql_server_fqdn" {
  value       = azurerm_postgresql_server.postgresqlserver.fqdn
}

output "postgresql_server_admin_username" {
  value       = "psqladmin@${azurerm_postgresql_server.postgresqlserver.name}"
}

output "postgresql_db_name" {
  value       = azurerm_postgresql_database.authorization_db.name
}