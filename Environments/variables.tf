variable "environmentLocation" {
  description = "region to deploy resources into"
  type        = string
  default     = "westus"
}

variable "environmentPrefix" {
  description = "environment prefix"
  type        = string
  default     = ""
}

variable "location_environmentPrefix" {
  description = "location environmentPrefix"
  type        = string
  default     = ""
}

variable "aspNet_environment" {
  description = "ASPNETCORE ENVIRONMENT"
  type        = string
  default     = ""
}

variable "react_app_env" {
  description = "react app environment name"
  type        = string
  default     = ""
}

# subscription id
variable "subscription_id" {
  description = "subscription id to deploy the environment in"
  type        = string
  default     = ""
}

# networking 
variable "EnvironmentNetClass" {
  description = "This will allow the environments to be deployed in the 10.0.0.0/8 or 172.16.0.0/12 private subnets"
  type        = string
  default     = ""
}

variable "EnvironmentNet" {
  description = "A number between 11 and 250 (but not 80,90,91) that will be used to use different IPv4 ranges."
  type        = string
  default     = ""
}


# ******* app service plans *****************************

variable "backend_function_appserviceplan_tier" {
  description = "backend function appserviceplan tier"
  type        = string
  default     = ""
}

variable "backend_function_appserviceplan_size" {
  description = "backend function appserviceplan size"
  type        = string
  default     = ""
}

# ***************************************
# webapp app service plan
variable "backend_webapp_appserviceplan_tier" {
  description = "backend webapp appserviceplan tier"
  type        = string
  default     = ""
}

variable "backend_webapp_appserviceplan_size" {
  description = "backend webapp appserviceplan size"
  type        = string
  default     = ""
}

# ***************************************
# backend shared app service plan
variable "backend_services_shared_appserviceplan_tier" {
  description = "backend services shared appserviceplan tier"
  type        = string
  default     = ""
}

variable "backend_services_shared_appserviceplan_size" {
  description = "backend services shared appserviceplan size"
  type        = string
  default     = ""
}


# ***************************************
# front end app service plan
variable "frontend_appserviceplan_tier" {
  description = "App service plan tier for frontend"
  type        = string
  default     = ""
}

variable "frontend_appserviceplan_size" {
  description = "App service plan size for frontend"
  type        = string
  default     = ""
}


# acr
variable "acr_login_server" {
  description = "acr login server"
  type        = string
}

variable "acr_username" {
  description = "acr name"
  type        = string
}

variable "acr_password" {
  description = "acr password"
  type        = string
}

# iothub
variable "sku_name" {
  description = "sku name for iothub"
  type        = string
  default     = ""
}

variable "sku_capacity" {
  description = "sku capacity for iothub"
  type        = string
  default     = ""
}

# apim 
variable "EnvironmentSKU_Apim" {
  description = "Environment SKU for Apim"
  type        = string
  default     = ""
}

# asset association service sql 
variable "asset_association_service_sql_db_edition" {
  type        = string
}

variable "asset_association_service_requested_service_objective_name" {
  type        = string
}

# company service sql 
variable "company_service_sql_db_edition" {
  type        = string
}

variable "company_service_requested_service_objective_name" {
  type        = string
}

# Device Inventory sql 
variable "device_inventory_sql_db_edition" {
  type        = string
}

variable "device_inventory_requested_service_objective_name" {
  type        = string
}

# EventManagement sql 
variable "event_management_sql_db_edition" {
  type        = string
}

variable "event_management_requested_service_objective_name" {
  type        = string
}

# event service sql 
variable "event_service_sql_db_edition" {
  type        = string
}

variable "event_service_requested_service_objective_name" {
  type        = string
}

# asset service sql 
variable "asset_service_sql_db_edition" {
  type        = string
}

variable "asset_service_requested_service_objective_name" {
  type        = string
}

# user service sql 
variable "user_service_sql_db_edition" {
  type        = string
}

variable "user_service_requested_service_objective_name" {
  type        = string
}


# app settings for certificate service

variable "certificate_clientId" {
  description = "AppReg clientID"
  type        = string
}

variable "certificate_securityGroupId" {
  description = "Certificate_SecurityGroupId"
  type        = string
}

#app settings for device inventory service
variable "device_inventory_clientId" {
  description = "AppReg clientID"
  type        = string
}

variable "device_inventory_securityGroupId" {
  description = "device inventory SecurityGroupId"
  type        = string
}

# SKU's for postgres
variable "postgresql_sku" {
  description = "SKU Name for this PostgreSQL Server"
  type        = string
  default     = ""
}
variable "postgresql_version" {
  description = "Specifies the version of PostgreSQL to use"
  type        = string
  default     = ""
}
variable "postgresql_storage" {
  description = "Max storage allowed for a server"
  type        = string
  default     = ""
}

# SpiceDB container compute resources
variable "authorizationdb_cpu" {
  description = "Number of cpu cores for authorization database container"
  type        = string
  default     = ""
}
variable "authorizationdb_memory" {
  description = "Memory in GB for authorization database container"
  type        = string
  default     = ""
}

# Auth0 testing variables
variable "auth0_tenant_url" {
  description = "URL for the Auth0 tenant"
  type        = string
  default     = ""  
}
variable "auth0_automation_clientId" {
  description = "Client Id for the in-house Automation Application in Auth0"
  type        = string
  default     = ""  
}
variable "auth0_automation_clientSecret" {
  description = "Client Secret for the in-house Automation Application in Auth0"
  type        = string
  default     = ""  
}

# vpn start and end Ipaddress
variable "rsystems_vpn1_startip_address" {
  type        = string
}
variable "rsystems_vpn1_endip_address" {
  type        = string
}
variable "rsystems_vpn2_startip_address" {
  type        = string
}
variable "rsystems_vpn2_endip_address" {
  type        = string
}
variable "wenco_vpn_startip_address" {
  type        = string
}
variable "wenco_vpn_endip_address" {
  type        = string
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