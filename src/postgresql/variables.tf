variable "backendservices_resource_group_name" {
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

# SKU's
variable "postgresql_sku" {
  description = "SKU Name for this PostgreSQL Server"
  type        = string
  default     = ""
}
variable "postgresql_version" {
  description = "Specifies the version of PostgreSQL to use"
  type        = string
  default     = ""
}
variable "postgresql_storage" {
  description = "Max storage allowed for a server"
  type        = string
  default     = ""
}

#vnet 
variable "EnvironmentNetClass" {
  description = "This will allow the environments to be deployed in the 10.0.0.0/8 or 172.16.0.0/12 private subnets"
  type        = string
  default     = ""
}

variable "EnvironmentNet" {
  description = "A number between 11 and 250 (but not 80,90,91) that will be used to use different IPv4 ranges."
  type        = string
  default     = ""
}
# vpn start and end Ipaddress
variable "rsystems_vpn1_startip_address" {
  type        = string
}
variable "rsystems_vpn1_endip_address" {
  type        = string
}
variable "rsystems_vpn2_startip_address" {
  type        = string
}
variable "rsystems_vpn2_endip_address" {
  type        = string
}
variable "wenco_vpn_startip_address" {
  type        = string
}
variable "wenco_vpn_endip_address" {
  type        = string
}