variable "environment_name" {}
variable "subscription_id" {}
variable "location" {}

# Gov - Allowed locations
variable "allowed_locations_policy_effect" {}
variable "allowed_locations_list" { type = list(any) }

# Required Tags
variable "ownerTagEffect" {}
variable "createdByTagEffect" {}
variable "approverTagEffect" {}
variable "requesterTagEffect" {}
variable "costCenterTagEffect" {}
variable "environmentTagEffect" {}
variable "purposeTagEffect" {}
variable "estimatedTimeFrameTagEffect" {}
variable "createdDateTagEffect" {}

# Cosmos
variable "cosmos_firewall_effect" {}
variable "cosmos_allowed_locations_list" { type = list(any) }
variable "cosmos_allowed_locations_effect" {}
variable "cosmos_disable_public_effect" {}
variable "cosmos_limit_throughput_value" {}
variable "cosmos_limit_throughput_effect" {}
variable "cosmos_private_link_effect" {}
variable "cosmos_account_disable_public_effect" {}

# App Service
variable "api_app_https_effect" {}
variable "function_app_https_effect" {}
variable "web_app_https_effect" {}
variable "app_services_disable_public_effect" {}
variable "api_app_require_auth_effect" {}
variable "function_app_require_auth_effect" {}
variable "web_app_require_auth_effect" {}
variable "api_app_configure_cors_effect" {}
variable "function_app_configure_cors_effect" {}
variable "web_app_configure_cors_effect" {}

# Security Center
variable "external_accounts_write_effect" {}
variable "external_accounts_read_effect" {}
variable "subscription_owners_effect" {}
variable "subscription_email_effect" {}
variable "subscription_law_agent_effect" {}
variable "vm_vuln_assessment_effect" {}
variable "vm_law_agent_effect" {}
variable "vm_encryption_effect" {}
variable "guest_configuration_effect" {}
variable "endpoint_protection_effect" {}

# Security Center
variable "storage_disallow_public_effect" {}
variable "storage_private_link_effect" {}
variable "storage_vnet_rules_effect" {}