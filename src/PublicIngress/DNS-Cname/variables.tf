variable "frontendwebapp_AzureDomain" {
  description = "create a cname in DNS record"
  type        = string
  default     = ""
}

variable "environmentPrefix" {
  description = "environment prefix"
  type        = string
  default     = ""
}

variable "apim_name" {
  description = "apim name"
  type        = string
  default     = ""
}