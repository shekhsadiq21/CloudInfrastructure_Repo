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