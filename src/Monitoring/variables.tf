
variable "rg_monitoring_name" {
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

variable "log_analytics_workspace_name" {
  description = "log analytics workspace name"
  type        = string
  default     = ""
}

variable "application_insights_name" {
  description = "App insights name"
  type        = string
  default     = ""
}