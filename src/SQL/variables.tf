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

variable "shared_resources_subnet_id" {
  description = "Integrate app with an Azure virtual network"
  type        = string
}

variable "backend_webapps_asp_subnet_id" {
  description = "Integrate app with an Azure virtual network"
  type        = string
}

# asset association service sql 
variable "asset_association_service_sql_db_edition" {
  type        = string
}

variable "asset_association_service_requested_service_objective_name" {
  type        = string
}

# company service sql 
variable "company_service_sql_db_edition" {
  type        = string
}

variable "company_service_requested_service_objective_name" {
  type        = string
}

# Device Inventory sql 
variable "device_inventory_sql_db_edition" {
  type        = string
}

variable "device_inventory_requested_service_objective_name" {
  type        = string
}

# EventManagement sql 
variable "event_management_sql_db_edition" {
  type        = string
}

variable "event_management_requested_service_objective_name" {
  type        = string
}

# event service sql 
variable "event_service_sql_db_edition" {
  type        = string
}

variable "event_service_requested_service_objective_name" {
  type        = string
}

# asset service sql 
variable "asset_service_sql_db_edition" {
  type        = string
}

variable "asset_service_requested_service_objective_name" {
  type        = string
}

# user service sql 
variable "user_service_sql_db_edition" {
  type        = string
}

variable "user_service_requested_service_objective_name" {
  type        = string
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