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

# ***************************************
# function app App service plan
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
