variable "public_ingress_resource_group_name" {
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
variable "app_service_plan_frontend_id" {
  description = "App service plan ID"
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
