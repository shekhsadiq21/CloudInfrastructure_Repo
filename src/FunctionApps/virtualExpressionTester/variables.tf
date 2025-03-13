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

# app service plan ID
variable "app_plan_backend_function_id" {
  description = "App service plan name for linux"
  type        = string
  default     = ""
}

variable "backend_function_asp_subnet_id" {
  description = "Integrate app with an Azure virtual network"
  type        = string
}

# # log analytics workspace id
# variable "log_analytics_workspace_id" {
#   description = "App service plan ID"
#   type        = string
# }

# application insights instrumentation key
variable "appinsights_instrumentation_key" {
  description = "appinsights instrumentation key"
  type        = string
}

# storage account primary connection string"
variable "storage_primary_connection_string" {
  description = "storage account primary connection string"
  type        = string
}

variable "storage_account_name" {
  description = "storage account name"
  type        = string
}

variable "storage_account_access_key" {
  description = "storage account access key"
  type        = string
}

# service bus
variable "service_bus_primary_connection_string" {
  description = "service bus connection string"
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