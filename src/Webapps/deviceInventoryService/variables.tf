variable "backendservices_resource_group_name" {
  description = "Name of the resource group to deploy"
  type        = string
  default     = ""
}
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
  description = "location environmentPrefix"
  type        = string
  default     = ""
}

variable "aspNet_environment" {
  description = "ASPNETCORE ENVIRONMENT"
  type        = string
  default     = ""
}

# app service plan ID
variable "app_plan_backend_webapp_id" {
  description = "App service plan id"
  type        = string
}

# subnet
variable "backend_webapps_asp_subnet_id" {
  description = "Integrate app with an Azure virtual network"
  type        = string
}

# # log analytics workspace id
# variable "log_analytics_workspace_id" {
#   description = "log analytics workspace id"
#   type        = string
# }

# application insights instrumentation key
variable "appinsights_instrumentation_key" {
  description = "appinsights instrumentation key"
  type        = string
}

# keyvault name
variable "key_vault_name" {
  description = "key vault name"
  type        = string
}

# acr credentials
variable "acr_login_server" {
  description = "acr login server"
  type        = string
}

variable "acr_username" {
  description = "acr username"
  type        = string
}

variable "acr_password" {
  description = "acr password"
  type        = string
}



# # app settings
variable "device_inventory_clientId" {
  description = "AppReg clientID"
  type        = string
}



variable "device_inventory_securityGroupId" {
  description = "device inventory SecurityGroupId"
  type        = string
}
