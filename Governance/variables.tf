variable "location" {
  description = "region to deploy resources into"
  type        = string
  default     = "westus"
}
variable "environmentPrefix" {
  description = "environment name"
  type        = string
  default     = ""
}
# subscription id
variable "subscription_id" {
  description = "subscription id to deploy the environment in"
  type        = string
  default     = ""
}
variable "location_environmentPrefix" {
  description = "location prefix"
  type        = string
  default     = ""
}
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