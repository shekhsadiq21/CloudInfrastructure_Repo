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

# Iot hub
variable "azurerm_iothub_hostname" {
  description = "iothub host name"
  type        = string
  default     = ""
}

variable "shared_resources_subnet_id" {
  description = "shared resources subnet id"
  type        = string
  default     = ""
}
variable "frontend_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_shared_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_webapps_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "backend_function_asp_subnet_id" {
  description = "subnet id"
  type        = string
  default     = ""
}
variable "customer_data_subnet_id" {
  description = "customer subnet id"
  type        = string
  default     = ""
}
# subscription id
variable "subscription_id" {
  description = "subscription id to deploy the environment in"
  type        = string
  default     = ""
}
# subscription id
variable "iotcomponents_resource_group_name" {
  description = "Iotcomponents resoure group name"
  type        = string
  default     = ""
}
variable "azurerm_iothub_name" {
  description = "iothub name"
  type        = string
  default     = ""
}
# vpn
variable "rsystems_vpn1_ipaddress" {
  type        = string
}
variable "rsystems_vpn2_ipaddress" {
  type        = string
}
variable "wenco_vpn_startip_address" {
  type        = string
}
