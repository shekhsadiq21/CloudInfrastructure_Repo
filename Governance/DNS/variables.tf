variable "location" {
  description = "Region to deploy resources into"
  type        = string
  default     = ""
}

variable "environmentPrefix" {
  description = "Environment name"
  type        = string
  default     = ""
}

variable "location_environmentPrefix" {
  description = "location prefix"
  type        = string
  default     = ""
}
variable "shared_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}