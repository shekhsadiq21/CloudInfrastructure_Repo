variable "environment_name" {}
variable "subscription_id" {}
variable "location" {}

variable "cosmos_firewall_effect" {}
variable "cosmos_allowed_locations_list" { type = list(any) }
variable "cosmos_allowed_locations_effect" {}
variable "cosmos_disable_public_effect" {}
variable "cosmos_limit_throughput_value" {}
variable "cosmos_limit_throughput_effect" {}
variable "cosmos_private_link_effect" {}
variable "cosmos_account_disable_public_effect" {}
