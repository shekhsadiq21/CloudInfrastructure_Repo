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

# application insights instrumentation key
variable "appinsights_instrumentation_key" {
  description = "App Insights Instrumentation Key"
  type        = string
}

variable "admin_base_url" {
  description = "Admin Base URL"
  type        = string
  default     = ""
}

variable "settings_persistence_base_url" {
  description = "Settings Persistence Base URL"
  type        = string
  default     = ""
}

variable "user_management_base_url" {
  description = "User Management Base URL"
  type        = string
  default     = ""
}

variable "event_service_base_url" {
  description = "Event Service Base URL"
  type        = string
  default     = ""
}

variable "react_app_env" {
  description = "React App Env"
  type        = string
  default     = ""
}

variable "react_azure_map_subscription_key" {
  description = "React Azure Map Subscription Key"
  type        = string
  default     = ""
}

