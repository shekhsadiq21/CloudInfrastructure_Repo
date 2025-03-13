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

variable "auth0_tenant_url" {
  description = "auth0 tenantUrl"
  type        = string
  default     = ""
}


variable "EnvironmentSKU_Apim" {
  description = "EnvironmentSKU for Apim"
  type        = string
  default     = ""
}

#API URLs
variable "admin_service_base_url" {
  description = "Administration Service base URL"
  type        = string
  default     = ""
}

variable "asset_association_service_base_url" {
  description = "Asset Association Service base URL"
  type        = string
  default     = ""
}

variable "asset_productivity_service_base_url" {
  description = "Asset Productivity Service base URL"
  type        = string
  default     = ""
}

variable "asset_service_base_url" {
  description = "Asset Service base URL"
  type        = string
  default     = ""
}

variable "certificate_service_base_url" {
  description = "Certificate Service base URL"
  type        = string
  default     = ""
}

variable "company_service_base_url" {
  description = "Company Service base URL"
  type        = string
  default     = ""
}

variable "device_inventory_service_base_url" {
  description = "Device Inventory Service base URL"
  type        = string
  default     = ""
}

variable "email_service_base_url" {
  description = "Email Service base URL"
  type        = string
  default     = ""
}

variable "event_management_service_base_url" {
  description = "Event Management Service base URL"
  type        = string
  default     = ""
}

variable "event_service_base_url" {
  description = "Event Service base URL"
  type        = string
  default     = ""
}

variable "pdf_generator_service_base_url" {
  description = "PDF Generator Service base URL"
  type        = string
  default     = ""
}

variable "settings_persistence_service_base_url" {
  description = "Settings Persistence Service base URL"
  type        = string
  default     = ""
}

variable "user_service_base_url" {
  description = "User Service base URL"
  type        = string
  default     = ""
}

variable "user_management_service_base_url" {
  description = "User Management Service base URL"
  type        = string
  default     = ""
}