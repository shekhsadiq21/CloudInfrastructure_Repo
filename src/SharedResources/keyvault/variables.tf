variable "environmentLocation" {
  description = "Region to deploy resources into"
  type        = string
  default     = ""
}

variable "environmentPrefix" {
  description = "environment prefix"
  type        = string
  default     = ""
}

variable "location_environmentPrefix" {
  description = "location environmentPrefix should be passed in tfvars"
  type        = string
  default     = ""
}

# rg
variable "shared_resource_group_name" {
  description = "shared resource group name"
  type        = string
  default     = ""
}

# vpn
variable "rsystems_vpn1_ipaddress" {
  type        = string
}
variable "rsystems_vpn2_ipaddress" {
  type        = string
}
variable "wenco_vpn_ipaddress" {
  type        = string
}
variable "azure_devops_ipaddress" {
  type        = string
}

# keyVault name
variable "key_vault_name" {
  description = "key vault name"
  type        = string
  default     = ""
}
variable "frontend_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_shared_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_webapps_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_function_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
# ****************      acces policy for services ****************
# admin
variable "administration_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "administration_service_principal_id" {
  description = "set Access policy"
  type        = string
}

#asset association service
variable "asset_association_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "asset_association_service_principal_id" {
  description = "set Access policy"
  type        = string
}

#asset productivity
variable "asset_productivity_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "asset_productivity_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# certificate service
variable "certificate_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "certificate_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# company service
variable "company_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "company_service_principal_id" {
  description = "set Access policy"
  type        = string
}


# device inventory
variable "device_inventory_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "device_inventory_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# gps simulators 
variable "gps_simulator_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "gps_simulator_principal_id" {
  description = "set Access policy"
  type        = string
}

# email 
variable "email_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "email_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# event management 
variable "event_management_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "event_management_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# event service 
variable "event_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "event_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# asset service 
variable "asset_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "asset_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# user service 
variable "user_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "user_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# Data Ingress service
variable "data_ingress_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "data_ingress_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# Event Consumer service
variable "event_consumer_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "event_consumer_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# export event processor service 
variable "export_event_processor_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "export_event_processor_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# pdf
variable "pdf_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "pdf_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# settings persistence service
variable "settings_persistence_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "settings_persistence_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# user
variable "user_management_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "user_management_service_principal_id" {
  description = "set Access policy"
  type        = string
}

# Telemetry Consumer service
variable "telemetry_consumer_service_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "telemetry_consumer_service_principal_id" {
  description = "set Access policy"
  type        = string
}


# virtualexpressiondeploymentverification
variable "virtualexpressiondeploymentverification_identity_id" {
  description = "set Access policy"
  type        = string
}

variable "virtualexpressiondeploymentverification_principal_id" {
  description = "set Access policy"
  type        = string
}


#**************************************
# cosmodb
variable "cosmo_db_primary_master_key" {
  description = "cosmo db Primary master key"
  type        = string
}

variable "cosmodb_endpoint_url" {
  description = "cosmodb endpoint url"
  type        = string
}

variable "cosmodb_main_database_name" {
  description = "cosmodb main database name"
  type        = string
}

variable "cosmodb_assetproductivity_database_name" {
  description = "cosmodb assetproductivity database name"
  type        = string
}

# storage account
variable "storage_primary_connection_string" {
  description = "storage primary connection string"
  type        = string
}

variable "storage_account_name" {
  description = "storage account name"
  type        = string
}

variable "public_storage_primary_connection_string" {
  description = "public storage primary connection string"
  type        = string
}

variable "public_storage_account_name" {
  description = "public storage account name"
  type        = string
}

# event hub connection strings
variable "eventhub_primary_connection_string" {
  description = "eventhub primary connection string"
  type        = string
}
#dlq
variable "eventhub_dlq_primary_connection_string" {
  description = "eventhub dlq primary connection string"
  type        = string
}

# # **************** web apps servcie ulrs **************** 
# admin
variable "admin_service_url" {
  description = "Service Urls"
  type        = string
}

# asset association
variable "asset_association_service_url" {
  description = "Service Urls"
  type        = string
}
# asset productivity
variable "asset_productivity_service_url" {
  description = "Service Urls"
  type        = string
}
# company
variable "company_service_url" {
  description = "Service Urls"
  type        = string
}
# device
variable "device_inventory_service_url" {
  description = "Service Urls"
  type        = string
}
# email
variable "email_service_url" {
  description = "Service Urls"
  type        = string
}
# pdf
variable "pdf_service_url" {
  description = "Service Urls"
  type        = string
}
# event management
variable "event_management_service_url" {
  description = "Service Urls"
  type        = string
}
# event service
variable "event_service_url" {
  description = "Service Urls"
  type        = string
}
# asset service
variable "asset_service_url" {
  description = "Service Urls"
  type        = string
}

# user service
variable "user_service_url" {
  description = "Service Urls"
  type        = string
}

# user
variable "user_management_service_authority" {
  description = "Service Urls"
  type        = string
}

# Persistence service
variable "settings_persistence_base_url" {
  description = "Service Urls"
  type        = string
}

# service bus
variable "service_bus_primary_connection_string" {
  description = "Service Bus"
  type        = string
}

variable "shared_resources_subnet_id" {
  description = "shared resources subnet id"
  type        = string
  default     = ""
}

# tsi
variable "tsi_data_access_fqdn" {
  description = "URL for tsi data access fqdn"
  type        = string
  default     = ""
}

# sql db
variable "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  type        = string
  default     = ""
}

variable "sql_server_password" {
  description = "sql server admin password"
  type        = string
  default     = ""
}

variable "sql_server_admin_login" {
  description = "sql server admin login"
  type        = string
  default     = ""
}

variable "db_name_asset_association_service" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_company_service" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_device_inventory" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_event_management" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_event_service" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_asset_service" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

variable "db_name_user_service" {
  description = "Database name of the Azure SQL Database created"
  type        = string
  default     = ""
}

# iothub
variable "iothub_fullaccess_policy_primary_connection_string" {
  description = "Iothub fullaccess policy"
  type        = string
  default     = ""
}

# Azure maps
variable "azuremap_primary_access_key" {
  description = "azuremap primary access key"
  type        = string
  default     = ""
}

# postgres
variable "postgresql_server_password" {
  type        = string
  default     = ""
}
variable "postgresql_server_admin_login" {
  type        = string
  default     = ""
}
variable "postgresql_server_fqdn" {
  type        = string
  default     = ""
}
variable "postgresql_db_name" {
  type        = string
  default     = ""
}
variable "postgresql_server_admin_username" {
  type        = string
  default     = ""
}

#Auth0

variable "auth0_tenant_url" {
  type        = string
  default     = ""  
}
variable "auth0_automation_clientId" {
  type        = string
  default     = ""  
}
variable "auth0_automation_clientSecret" {
  type        = string
  default     = ""  
}

# APIM
variable "apim_testing_subscription_key" {
  type        = string
  default     = ""
}
variable "apim_gateway_url" {
  type        = string
  default     = ""
}