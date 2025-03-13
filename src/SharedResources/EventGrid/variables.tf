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

variable "eventhub_ingressdata_id" {
  description = "data ingress event hub ID"
  type        = string
  default     = ""
}

variable "location_environmentPrefix" {
  description = "location environmentPrefix"
  type        = string
  default     = ""
}

variable "shared_resource_group_name" {
  description = "shared resource group name"
  type        = string
  default     = ""
}

variable "storage_id" {
  description = "storage account ID"
  type        = string
  default     = ""
}