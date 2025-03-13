environment_name = "Governance"
subscription_id  = "2eb45bac-2a47-44fc-844e-81474a62a406"
location         = "West US 2"

# Gov - Allowed locations
allowed_locations_policy_effect = "Audit"
allowed_locations_list          = ["West US 2", "Global"]

# Required Tags
ownerTagEffect              = "Deny"
createdByTagEffect          = "Deny"
approverTagEffect           = "Deny"
requesterTagEffect          = "Deny"
costCenterTagEffect         = "Deny"
environmentTagEffect        = "Deny"
purposeTagEffect            = "Audit"
estimatedTimeFrameTagEffect = "Audit"
createdDateTagEffect        = "Audit"

# Cosmos
cosmos_firewall_effect               = "Audit"
cosmos_allowed_locations_list        = ["West US 2"]
cosmos_allowed_locations_effect      = "audit"
cosmos_disable_public_effect         = "Disabled"
cosmos_limit_throughput_value        = 2400
cosmos_limit_throughput_effect       = "audit"
cosmos_private_link_effect           = "Audit"
cosmos_account_disable_public_effect = "Disabled"

# App Service
api_app_https_effect               = "Audit"
function_app_https_effect          = "Audit"
web_app_https_effect               = "Audit"
app_services_disable_public_effect = "AuditIfNotExists"
api_app_require_auth_effect        = "AuditIfNotExists"
function_app_require_auth_effect   = "AuditIfNotExists"
web_app_require_auth_effect        = "AuditIfNotExists"
api_app_configure_cors_effect      = "AuditIfNotExists"
function_app_configure_cors_effect = "AuditIfNotExists"
web_app_configure_cors_effect      = "AuditIfNotExists"

# Security Center
external_accounts_write_effect = "AuditIfNotExists"
external_accounts_read_effect  = "AuditIfNotExists"
subscription_owners_effect     = "AuditIfNotExists"
subscription_email_effect      = "AuditIfNotExists"
subscription_law_agent_effect  = "AuditIfNotExists"
vm_vuln_assessment_effect      = "AuditIfNotExists"
vm_law_agent_effect            = "AuditIfNotExists"
vm_encryption_effect           = "AuditIfNotExists"
guest_configuration_effect     = "AuditIfNotExists"
endpoint_protection_effect     = "AuditIfNotExists"

# Storage
storage_disallow_public_effect = "audit"
storage_private_link_effect    = "AuditIfNotExists"
storage_vnet_rules_effect      = "Audit"
