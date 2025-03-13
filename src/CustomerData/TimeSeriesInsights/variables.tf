variable "user_data_resource_group_name" {
  description = "Name of the resource group to deploy"
  type        = string
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

# storage account details
variable "public_storage_account_name" {
  description = "storage account name"
  type        = string
  default     = ""
}

variable "public_storage_account_access_key" {
  description = "storage primary access key"
  type        = string
  default     = ""
}