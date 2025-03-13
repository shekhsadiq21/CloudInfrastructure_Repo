terraform {
  backend "azurerm" {
    # resource_group_name  = "wen-gov-wus2-terraform-rg"
    # storage_account_name = "wengovwus2terraformtf"
    # container_name       = "wencocloud-management"
    # key                  = "policy-dev.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.80.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

# Gov - Allowed locations
module "allowed_locations" {
  source                 = "../src/policies/allowed_locations"
  allowed_locations_list = var.allowed_locations_list
  environment_name       = var.environment_name
  policy_effect          = var.allowed_locations_policy_effect
  subscription_id        = var.subscription_id
}

# Required Tags
module "required_tags" {
  source                      = "../src/policies/required_tags"
  approverTagEffect           = var.approverTagEffect
  costCenterTagEffect         = var.costCenterTagEffect
  createdByTagEffect          = var.createdByTagEffect
  createdDateTagEffect        = var.createdDateTagEffect
  environment_name            = var.environment_name
  environmentTagEffect        = var.environmentTagEffect
  estimatedTimeFrameTagEffect = var.estimatedTimeFrameTagEffect
  ownerTagEffect              = var.ownerTagEffect
  purposeTagEffect            = var.purposeTagEffect
  requesterTagEffect          = var.requesterTagEffect
  subscription_id             = var.subscription_id
}

# Cosmos
module "cosmos_db" {
  source                               = "../src/policies/cosmos_db"
  cosmos_account_disable_public_effect = var.cosmos_account_disable_public_effect
  cosmos_allowed_locations_effect      = var.cosmos_allowed_locations_effect
  cosmos_allowed_locations_list        = var.cosmos_allowed_locations_list
  cosmos_disable_public_effect         = var.cosmos_disable_public_effect
  cosmos_firewall_effect               = var.cosmos_firewall_effect
  cosmos_limit_throughput_effect       = var.cosmos_limit_throughput_effect
  cosmos_limit_throughput_value        = var.cosmos_limit_throughput_value
  cosmos_private_link_effect           = var.cosmos_private_link_effect
  environment_name                     = var.environment_name
  location                             = var.location
  subscription_id                      = var.subscription_id
}

module "app_service" {
  source                             = "../src/policies/app_service"
  api_app_configure_cors_effect      = var.api_app_configure_cors_effect
  api_app_https_effect               = var.api_app_https_effect
  api_app_require_auth_effect        = var.api_app_require_auth_effect
  app_services_disable_public_effect = var.app_services_disable_public_effect
  environment_name                   = var.environment_name
  function_app_configure_cors_effect = var.function_app_configure_cors_effect
  function_app_https_effect          = var.function_app_https_effect
  function_app_require_auth_effect   = var.function_app_require_auth_effect
  subscription_id                    = var.subscription_id
  web_app_configure_cors_effect      = var.web_app_configure_cors_effect
  web_app_https_effect               = var.web_app_https_effect
  web_app_require_auth_effect        = var.web_app_require_auth_effect
}

module "security_center" {
  source                         = "../src/policies/security_center"
  endpoint_protection_effect     = var.endpoint_protection_effect
  environment_name               = var.environment_name
  external_accounts_read_effect  = var.external_accounts_read_effect
  external_accounts_write_effect = var.external_accounts_write_effect
  guest_configuration_effect     = var.guest_configuration_effect
  subscription_email_effect      = var.subscription_email_effect
  subscription_id                = var.subscription_id
  subscription_law_agent_effect  = var.subscription_law_agent_effect
  subscription_owners_effect     = var.subscription_owners_effect
  vm_encryption_effect           = var.vm_encryption_effect
  vm_law_agent_effect            = var.vm_law_agent_effect
  vm_vuln_assessment_effect      = var.vm_vuln_assessment_effect
}

# Storage
module "storage" {
  source                         = "../src/policies/storage"
  environment_name               = var.environment_name
  storage_disallow_public_effect = var.storage_disallow_public_effect
  storage_private_link_effect    = var.storage_private_link_effect
  storage_vnet_rules_effect      = var.storage_vnet_rules_effect
  subscription_id                = var.subscription_id
}
