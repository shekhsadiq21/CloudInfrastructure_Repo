variable "iotcomponents_resource_group_name" {
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
variable "iot_subnet_id" {
  description = "iot components subnet id"
  type        = string
  default     = ""
}
variable "shared_resources_subnet_id" {
  description = "subnet id"
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

# vpn
variable "rsystems_vpn1_ipaddress" {
  type        = string
}
variable "rsystems_vpn2_ipaddress" {
  type        = string
}
variable "wenco_vpn_ipaddress" {
  type        = string
}
