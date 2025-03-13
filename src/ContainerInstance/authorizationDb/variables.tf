# name of the RG
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

variable "cpu" {
  description = "CPU cores allocated for Azure Container Instance"
  type        = string
  default     = ""
}

variable "memory" {
  description = "Memory allocated for Azure Container Instance in GB"
  type        = string
  default     = ""
}

# subnet
variable "network_profile_cis_id" {
  description = "Integrate app with an Azure virtual network"
  type        = string
}

# acr credentials
variable "acr_login_server" {
  description = "acr login server"
  type        = string
}

variable "acr_username" {
  description = "acr name"
  type        = string
}

variable "acr_password" {
  description = "acr password"
  type        = string
}


# env vars
variable "spicedb_preshared_key" {
  description = "spicedb auto generated access token"
  type        = string
}

variable "postgresql_authorization_db_cs" {
  description = "postgresql connection string"
  type        = string
}
