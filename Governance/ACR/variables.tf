variable "resource_group_name" {
  description = "resource group name"
  type        = string
  default     = "wcp-gov-wus2-acr-rg"
}
variable "location" {
  description = "location"
  type        = string
  default     = ""
}
variable "environmentPrefix" {
  description = "Tag name"
  type        = string
  default     = ""
}
variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
  default     = "wcpgovwus2acr"
}
variable "key_vault_name" {
  description = "key vault name"
  type        = string
  default     = "wcp-gov-wus2-acr-kv"
}