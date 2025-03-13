variable "environmentPrefix" {
  description = "environment prefix"
  type        = string
  default     = ""
}

# name of the rg
variable "shared_resource_group_name" {
  description = "Name of the resource group to deploy"
  type        = string
  default     = ""
}