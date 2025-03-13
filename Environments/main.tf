terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 2.99.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

# Networking module
module "Networking" {
  source                     = "../src/Networking"
  environmentLocation        = var.environmentLocation
  EnvironmentNet             = var.EnvironmentNet
  EnvironmentNetClass        = var.EnvironmentNetClass
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

# SharedResources resource group
module "SharedResources_rg" {
  source                     = "../src/SharedResources"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

# AppServiceplans module
module "SharedResources_appserviceplans" {
  source                                      = "../src/SharedResources/AppServiceplans"
  backend_function_appserviceplan_size        = var.backend_function_appserviceplan_size
  backend_function_appserviceplan_tier        = var.backend_function_appserviceplan_tier
  backend_services_shared_appserviceplan_size = var.backend_services_shared_appserviceplan_size
  backend_services_shared_appserviceplan_tier = var.backend_services_shared_appserviceplan_tier
  backend_webapp_appserviceplan_size          = var.backend_webapp_appserviceplan_size
  backend_webapp_appserviceplan_tier          = var.backend_webapp_appserviceplan_tier
  environmentLocation                         = var.environmentLocation
  environmentPrefix                           = var.environmentPrefix
  frontend_appserviceplan_size                = var.frontend_appserviceplan_size
  frontend_appserviceplan_tier                = var.frontend_appserviceplan_tier
  location_environmentPrefix                  = var.location_environmentPrefix
  shared_resource_group_name                  = module.SharedResources_rg.shared_resource_group_name
}
# Monitoring Module - creates log analytics workspace and Application insights
module "monitoring" {
  source                     = "../src/Monitoring"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

# Resource group for customerdata
module "customerdata_rg" {
  source                     = "../src/CustomerData"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

# Time series insights module
module "customerdata_tsi" {
  source                               = "../src/CustomerData/TimeSeriesInsights"
  environmentLocation                  = var.environmentLocation
  environmentPrefix                    = var.environmentPrefix
  location_environmentPrefix           = var.location_environmentPrefix
  public_storage_account_access_key    = module.storage_account_public.public_storage_account_access_key
  public_storage_account_name          = module.storage_account_public.public_storage_account_name
  user_data_resource_group_name        = module.customerdata_rg.user_data_resource_group_name
}

# Resource group for IotComponents
module "iotcomponents_rg" {
  source                     = "../src/IotComponents"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

# IotHub & DPS module
module "iot_components_iothub_dps" {
  source                             = "../src/IotComponents/IotHub-Dps"
  environmentLocation                = var.environmentLocation
  environmentPrefix                  = var.environmentPrefix
  eventhub_eventdata_iothub_rule     = module.iot_components_eventhub.eventhub_eventdata_iothub_rule
  eventhub_msgcapture_rule           = module.iot_components_eventhub.eventhub_msgcapture_rule
  eventhub_sensordata_gen2_rule      = module.iot_components_eventhub.eventhub_sensordata_gen2_rule
  eventhub_telemetrydata_iothub_rule = module.iot_components_eventhub.eventhub_telemetrydata_iothub_rule
  iotcomponents_resource_group_name  = module.iotcomponents_rg.iotcomponents_resource_group_name
  location_environmentPrefix         = var.location_environmentPrefix
  sku_capacity                       = var.sku_capacity
  sku_name                           = var.sku_name
}


# Event hub namespace module
module "iot_components_eventhub" {
  source                            = "../src/IotComponents/Eventhubs"
  backend_function_asp_subnet_id    = module.Networking.backend_function_asp_subnet_id
  backend_shared_asp_subnet_id      = module.Networking.backend_shared_asp_subnet_id
  backend_webapps_asp_subnet_id     = module.Networking.backend_webapps_asp_subnet_id
  environmentLocation               = var.environmentLocation
  environmentPrefix                 = var.environmentPrefix
  frontend_asp_subnet_id            = module.Networking.frontend_asp_subnet_id
  iot_subnet_id                     = module.Networking.iot_subnet_id
  iotcomponents_resource_group_name = module.iotcomponents_rg.iotcomponents_resource_group_name
  location_environmentPrefix        = var.location_environmentPrefix
  rsystems_vpn1_ipaddress           = var.rsystems_vpn1_ipaddress
  rsystems_vpn2_ipaddress           = var.rsystems_vpn2_ipaddress
  shared_resources_subnet_id        = module.Networking.shared_resources_subnet_id
  wenco_vpn_ipaddress               = var.wenco_vpn_ipaddress
}

# storage accounts module
module "sharedResources_storage" {
  source                         = "../src/SharedResources/Storage-Account"
  azurerm_iothub_hostname        = module.iot_components_iothub_dps.azurerm_iothub_hostname
  azurerm_iothub_name            = module.iot_components_iothub_dps.azurerm_iothub_name
  backend_function_asp_subnet_id = module.Networking.backend_function_asp_subnet_id
  backend_shared_asp_subnet_id   = module.Networking.backend_shared_asp_subnet_id
  backend_webapps_asp_subnet_id  = module.Networking.backend_webapps_asp_subnet_id
  customer_data_subnet_id        = module.Networking.customer_data_subnet_id
  environmentLocation            = var.environmentLocation
  environmentPrefix              = var.environmentPrefix
  frontend_asp_subnet_id         = module.Networking.frontend_asp_subnet_id
  iotcomponents_resource_group_name = module.iotcomponents_rg.iotcomponents_resource_group_name 
  location_environmentPrefix     = var.location_environmentPrefix
  rsystems_vpn1_ipaddress        = var.rsystems_vpn1_ipaddress
  rsystems_vpn2_ipaddress        = var.rsystems_vpn2_ipaddress
  shared_resource_group_name     = module.SharedResources_rg.shared_resource_group_name
  shared_resources_subnet_id     = module.Networking.shared_resources_subnet_id
  subscription_id                = var.subscription_id
  wenco_vpn_startip_address      = var.wenco_vpn_startip_address
}


# storage account open to all networks
module "storage_account_public" {
  source                        = "../src/SharedResources/storage-account-public"
  environmentLocation           = var.environmentLocation
  environmentPrefix             = var.environmentPrefix
  location_environmentPrefix    = var.location_environmentPrefix
  shared_resource_group_name    = module.SharedResources_rg.shared_resource_group_name
}


# cosmodb module
module "sharedResources_cosmodb_account" {
  source                         = "../src/SharedResources/Cosmos-DB-account"
  backend_function_asp_subnet_id = module.Networking.backend_function_asp_subnet_id
  backend_shared_asp_subnet_id   = module.Networking.backend_shared_asp_subnet_id
  backend_webapps_asp_subnet_id  = module.Networking.backend_webapps_asp_subnet_id
  environmentLocation            = var.environmentLocation
  environmentPrefix              = var.environmentPrefix
  frontend_asp_subnet_id         = module.Networking.frontend_asp_subnet_id
  location_environmentPrefix     = var.location_environmentPrefix
  rsystems_vpn1_ipaddress        = var.rsystems_vpn1_ipaddress
  rsystems_vpn2_ipaddress        = var.rsystems_vpn2_ipaddress
  shared_resource_group_name     = module.SharedResources_rg.shared_resource_group_name
  shared_resources_subnet_id     = module.Networking.shared_resources_subnet_id
  wenco_vpn_ipaddress            = var.wenco_vpn_ipaddress
}

# event grid module
module "sharedResources_eventgrid" {
  source                     = "../src/SharedResources/EventGrid"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  eventhub_ingressdata_id    = module.iot_components_eventhub.eventhub_ingressdata_id
  location_environmentPrefix = var.location_environmentPrefix
  shared_resource_group_name = module.SharedResources_rg.shared_resource_group_name
  storage_id                 = module.sharedResources_storage.storage_id
}

# service bus module
module "sharedResources_servicebus" {
  source                     = "../src/SharedResources/ServiceBus"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
  shared_resource_group_name = module.SharedResources_rg.shared_resource_group_name
}

#  Azure maps module
module "sharedResources_maps" {
  source                     = "../src/SharedResources/AzureMaps"
  environmentPrefix          = var.environmentPrefix
  shared_resource_group_name = module.SharedResources_rg.shared_resource_group_name
}

# keyVault module
module "sharedResources_keyvault" {
  source                                               = "../src/SharedResources/keyvault"
  admin_service_url                                    = module.admin_service.admin_service_url
  administration_service_identity_id                   = module.admin_service.administration_service_identity_id
  administration_service_principal_id                  = module.admin_service.administration_service_principal_id
  apim_gateway_url                                     = module.apim.apim_gateway_url
  apim_testing_subscription_key                        = module.apim.apim_testing_subscription_key
  asset_association_service_identity_id                = module.asset_association_service.asset_association_service_identity_id
  asset_association_service_principal_id               = module.asset_association_service.asset_association_service_principal_id
  asset_association_service_url                        = module.asset_association_service.asset_association_service_url
  asset_productivity_service_identity_id               = module.asset_productivity_service.asset_productivity_service_identity_id
  asset_productivity_service_principal_id              = module.asset_productivity_service.asset_productivity_service_principal_id
  asset_productivity_service_url                       = module.asset_productivity_service.asset_productivity_service_url
  auth0_automation_clientId                            = var.auth0_automation_clientId
  auth0_automation_clientSecret                        = var.auth0_automation_clientSecret
  auth0_tenant_url                                     = var.auth0_tenant_url
  asset_service_identity_id                            = module.asset_service.asset_service_identity_id
  asset_service_principal_id                           = module.asset_service.asset_service_principal_id
  asset_service_url                                    = module.asset_service.asset_service_url
  azure_devops_ipaddress                               = var.azure_devops_ipaddress
  azuremap_primary_access_key                          = module.sharedResources_maps.azuremap_primary_access_key
  backend_function_asp_subnet_id                       = module.Networking.backend_function_asp_subnet_id
  backend_shared_asp_subnet_id                         = module.Networking.backend_shared_asp_subnet_id
  backend_webapps_asp_subnet_id                        = module.Networking.backend_webapps_asp_subnet_id
  certificate_service_identity_id                      = module.certificate_service.certificate_service_identity_id
  certificate_service_principal_id                     = module.certificate_service.certificate_service_principal_id
  company_service_identity_id                          = module.company_service.company_service_identity_id
  company_service_principal_id                         = module.company_service.company_service_principal_id
  company_service_url                                  = module.company_service.company_service_url
  cosmo_db_primary_master_key                          = module.sharedResources_cosmodb_account.cosmo_db_primary_master_key
  cosmodb_assetproductivity_database_name              = module.sharedResources_cosmodb_account.cosmodb_assetproductivity_database_name
  cosmodb_endpoint_url                                 = module.sharedResources_cosmodb_account.cosmodb_endpoint_url
  cosmodb_main_database_name                           = module.sharedResources_cosmodb_account.cosmodb_main_database_name
  data_ingress_service_identity_id                     = module.data_ingress_service.data_ingress_service_identity_id
  data_ingress_service_principal_id                    = module.data_ingress_service.data_ingress_service_principal_id
  db_name_asset_association_service                    = module.sql_db.db_name_asset_association_service
  db_name_asset_service                                = module.sql_db.db_name_asset_service
  db_name_company_service                              = module.sql_db.db_name_company_service
  db_name_device_inventory                             = module.sql_db.db_name_device_inventory
  db_name_event_management                             = module.sql_db.db_name_event_management
  db_name_event_service                                = module.sql_db.db_name_event_service
  db_name_user_service                                 = module.sql_db.db_name_user_service
  device_inventory_service_identity_id                 = module.device_inventory_service.device_inventory_service_identity_id
  device_inventory_service_principal_id                = module.device_inventory_service.device_inventory_service_principal_id
  device_inventory_service_url                         = module.device_inventory_service.device_inventory_service_url
  email_service_identity_id                            = module.email_service.email_service_identity_id
  email_service_principal_id                           = module.email_service.email_service_principal_id
  email_service_url                                    = module.email_service.email_service_url
  environmentLocation                                  = var.environmentLocation
  environmentPrefix                                    = var.environmentPrefix
  event_consumer_service_identity_id                   = module.event_consumer_service.event_consumer_service_identity_id
  event_consumer_service_principal_id                  = module.event_consumer_service.event_consumer_service_principal_id 
  event_management_service_identity_id                 = module.event_management_service.event_management_service_identity_id
  event_management_service_principal_id                = module.event_management_service.event_management_service_principal_id
  event_management_service_url                         = module.event_management_service.event_management_service_url
  event_service_identity_id                            = module.event_service.event_service_identity_id
  event_service_principal_id                           = module.event_service.event_service_principal_id
  event_service_url                                    = module.event_service.event_service_url
  eventhub_dlq_primary_connection_string               = module.iot_components_eventhub.eventhub_dlq_primary_connection_string
  eventhub_primary_connection_string                   = module.iot_components_eventhub.eventhub_primary_connection_string
  export_event_processor_service_identity_id           = module.export_event_processor.export_event_processor_service_identity_id
  export_event_processor_service_principal_id          = module.export_event_processor.export_event_processor_service_principal_id
  frontend_asp_subnet_id                               = module.Networking.frontend_asp_subnet_id
  gps_simulator_identity_id                            = module.Simulator.gps_simulator_identity_id
  gps_simulator_principal_id                           = module.Simulator.gps_simulator_principal_id
  iothub_fullaccess_policy_primary_connection_string   = module.iot_components_iothub_dps.iothub_fullaccess_policy_primary_connection_string
  location_environmentPrefix                           = var.location_environmentPrefix
  pdf_service_identity_id                              = module.pdf_generator_service.pdf_service_identity_id
  pdf_service_principal_id                             = module.pdf_generator_service.pdf_service_principal_id
  pdf_service_url                                      = module.pdf_generator_service.pdf_service_url
  postgresql_db_name                                   = module.postgresql_db.postgresql_db_name
  postgresql_server_admin_login                        = module.postgresql_db.postgresql_server_admin_login
  postgresql_server_admin_username                     = module.postgresql_db.postgresql_server_admin_username
  postgresql_server_fqdn                               = module.postgresql_db.postgresql_server_fqdn
  postgresql_server_password                           = module.postgresql_db.postgresql_server_password
  public_storage_account_name                          = module.storage_account_public.public_storage_account_name
  public_storage_primary_connection_string             = module.storage_account_public.public_storage_primary_connection_string
  rsystems_vpn1_ipaddress                              = var.rsystems_vpn1_ipaddress
  rsystems_vpn2_ipaddress                              = var.rsystems_vpn2_ipaddress
  service_bus_primary_connection_string                = module.sharedResources_servicebus.service_bus_primary_connection_string
  settings_persistence_base_url                        = module.settings_persistence_service.settings_persistence_base_url
  settings_persistence_service_identity_id             = module.settings_persistence_service.settings_persistence_service_identity_id
  settings_persistence_service_principal_id            = module.settings_persistence_service.settings_persistence_service_principal_id
  shared_resource_group_name                           = module.SharedResources_rg.shared_resource_group_name
  shared_resources_subnet_id                           = module.Networking.shared_resources_subnet_id
  sql_server_admin_login                               = module.sql_db.sql_server_admin_login
  sql_server_fqdn                                      = module.sql_db.sql_server_fqdn
  sql_server_password                                  = module.sql_db.sql_server_password
  storage_account_name                                 = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string                    = module.sharedResources_storage.storage_primary_connection_string
  telemetry_consumer_service_identity_id               = module.telemetry_consumer_service.telemetry_consumer_service_identity_id
  telemetry_consumer_service_principal_id              = module.telemetry_consumer_service.telemetry_consumer_service_principal_id
  tsi_data_access_fqdn                                 = module.customerdata_tsi.tsi_data_access_fqdn
  user_management_service_authority                    = module.user_management_service.user_management_service_authority
  user_management_service_identity_id                  = module.user_management_service.user_management_service_identity_id
  user_management_service_principal_id                 = module.user_management_service.user_management_service_principal_id
  user_service_identity_id                             = module.user_service.user_service_identity_id
  user_service_principal_id                            = module.user_service.user_service_principal_id
  user_service_url                                     = module.user_service.user_service_url
  virtualexpressiondeploymentverification_identity_id  = module.virtual_expression_deployment_verification.virtualexpressiondeploymentverification_identity_id
  virtualexpressiondeploymentverification_principal_id = module.virtual_expression_deployment_verification.virtualexpressiondeploymentverification_principal_id
  wenco_vpn_ipaddress                                  = var.wenco_vpn_ipaddress
}

# sql DB
module "sql_db" {
  source                                                       = "../src/SQL"
  asset_association_service_requested_service_objective_name   = var.asset_association_service_requested_service_objective_name
  asset_association_service_sql_db_edition                     = var.asset_association_service_sql_db_edition
  asset_service_requested_service_objective_name               = var.asset_service_requested_service_objective_name
  asset_service_sql_db_edition                                 = var.asset_service_sql_db_edition
  backend_webapps_asp_subnet_id                                = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name                          = module.backend_services_rg.backendservices_resource_group_name
  company_service_requested_service_objective_name             = var.company_service_requested_service_objective_name
  company_service_sql_db_edition                               = var.company_service_sql_db_edition
  device_inventory_requested_service_objective_name            = var.device_inventory_requested_service_objective_name
  device_inventory_sql_db_edition                              = var.device_inventory_sql_db_edition
  environmentLocation                                          = var.environmentLocation
  environmentPrefix                                            = var.environmentPrefix
  event_management_requested_service_objective_name            = var.event_management_requested_service_objective_name
  event_management_sql_db_edition                              = var.event_management_sql_db_edition
  event_service_requested_service_objective_name               = var.event_service_requested_service_objective_name
  event_service_sql_db_edition                                 = var.event_service_sql_db_edition
  location_environmentPrefix                                   = var.location_environmentPrefix
  rsystems_vpn1_endip_address                                  = var.rsystems_vpn1_endip_address
  rsystems_vpn1_startip_address                                = var.rsystems_vpn1_startip_address
  rsystems_vpn2_endip_address                                  = var.rsystems_vpn2_endip_address
  rsystems_vpn2_startip_address                                = var.rsystems_vpn2_startip_address 
  shared_resources_subnet_id                                   = module.Networking.shared_resources_subnet_id
  user_service_requested_service_objective_name                = var.user_service_requested_service_objective_name
  user_service_sql_db_edition                                  = var.user_service_sql_db_edition
  wenco_vpn_endip_address                                      = var.wenco_vpn_endip_address
  wenco_vpn_startip_address                                    = var.wenco_vpn_startip_address
}

module "postgresql_db" {
  source                                             = "../src/postgresql"
  backendservices_resource_group_name                = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                                = var.environmentLocation
  EnvironmentNet                                     = var.EnvironmentNet
  EnvironmentNetClass                                = var.EnvironmentNetClass
  environmentPrefix                                  = var.environmentPrefix
  location_environmentPrefix                         = var.location_environmentPrefix
  postgresql_sku                                     = var.postgresql_sku
  postgresql_storage                                 = var.postgresql_storage
  postgresql_version                                 = var.postgresql_version
  rsystems_vpn1_endip_address                        = var.rsystems_vpn1_endip_address
  rsystems_vpn1_startip_address                      = var.rsystems_vpn1_startip_address
  rsystems_vpn2_endip_address                        = var.rsystems_vpn2_endip_address
  rsystems_vpn2_startip_address                      = var.rsystems_vpn2_startip_address 
  wenco_vpn_endip_address                            = var.wenco_vpn_endip_address
  wenco_vpn_startip_address                          = var.wenco_vpn_startip_address
}

# backend services rg
module "backend_services_rg" {
  source                     = "../src/Webapps"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}


# DNS cNames
module "dns" {
  source                     = "../src/PublicIngress/DNS-Cname"
  environmentPrefix          = var.environmentPrefix
  frontendwebapp_AzureDomain = module.frontEnd.frontendwebapp_AzureDomain
  apim_name                  = module.apim.apim_name
}


# public ingress services rg
module "public_ingress_rg" {
  source                     = "../src/PublicIngress"
  environmentLocation        = var.environmentLocation
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}

module "frontEnd" {
  source = "../src/PublicIngress/frontEnd"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  app_service_plan_frontend_id       = module.SharedResources_appserviceplans.app_service_plan_frontend_id
  appinsights_instrumentation_key    = module.monitoring.appinsights_instrumentation_key
  environmentLocation                = var.environmentLocation
  environmentPrefix                  = var.environmentPrefix
  location_environmentPrefix         = var.location_environmentPrefix
  public_ingress_resource_group_name = module.public_ingress_rg.public_ingress_resource_group_name
}

# static web app
module "static_frontend_app" {
  source                             = "../src/PublicIngress/staticWebApp"
  environmentLocation                = var.environmentLocation
  environmentPrefix                  = var.environmentPrefix
  location_environmentPrefix         = var.location_environmentPrefix
  public_ingress_resource_group_name = module.public_ingress_rg.public_ingress_resource_group_name
  appinsights_instrumentation_key    = module.monitoring.appinsights_instrumentation_key
  react_app_env                      = var.react_app_env
  react_azure_map_subscription_key   = module.sharedResources_maps.azuremap_primary_access_key
  admin_base_url                     = module.admin_service.admin_service_url
  settings_persistence_base_url      = module.settings_persistence_service.settings_persistence_base_url
  user_management_base_url           = module.user_management_service.user_management_service_authority
  event_service_base_url             = module.event_service.event_service_url
}

# APIM
module "apim" {
  source                                = "../src/PublicIngress/APIM"
  environmentLocation                   = var.environmentLocation
  environmentPrefix                     = var.environmentPrefix
  EnvironmentSKU_Apim                   = var.EnvironmentSKU_Apim
  location_environmentPrefix            = var.location_environmentPrefix
  public_ingress_resource_group_name    = module.public_ingress_rg.public_ingress_resource_group_name
  auth0_tenant_url                      = var.auth0_tenant_url
  admin_service_base_url                = module.admin_service.admin_service_url
  asset_association_service_base_url    = module.asset_association_service.asset_association_service_url
  asset_productivity_service_base_url   = module.asset_productivity_service.asset_productivity_service_url
  asset_service_base_url                = module.asset_service.asset_service_url
  certificate_service_base_url          = module.certificate_service.certificate_service_url
  company_service_base_url              = module.company_service.company_service_url
  device_inventory_service_base_url     = module.device_inventory_service.device_inventory_service_url
  email_service_base_url                = module.email_service.email_service_url
  event_management_service_base_url     = module.event_management_service.event_management_service_url
  event_service_base_url                = module.event_service.event_service_url
  pdf_generator_service_base_url        = module.pdf_generator_service.pdf_service_url
  settings_persistence_service_base_url = module.settings_persistence_service.settings_persistence_base_url
  user_service_base_url                 = module.user_service.user_service_url
  user_management_service_base_url      = module.user_management_service.user_management_service_authority

}

# Admin Service module
module "admin_service" {
  source = "../src/Webapps/adminService"
  # log_analytics_workspace_id          = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  user_management_service_authority   = module.user_management_service.user_management_service_authority
}

# Asset Productivity Service
module "asset_productivity_service" {
  source = "../src/Webapps/assetProductivityService"
  # log_analytics_workspace_id          = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  front_end_authority                 = module.frontEnd.front_end_authority
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# Authorization Database module
module "authorization_db" {
  source = "../src/ContainerInstance/authorizationDb"
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  cpu                                 = var.authorizationdb_cpu
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  location_environmentPrefix          = var.location_environmentPrefix
  memory                              = var.authorizationdb_memory
  network_profile_cis_id              = module.Networking.network_profile_cis_id
  postgresql_authorization_db_cs      = module.sharedResources_keyvault.postgresql_authorization_db_cs
  spicedb_preshared_key               = module.sharedResources_keyvault.spicedb_preshared_key
}

# certificate Service
module "certificate_service" {
  source = "../src/Webapps/certificateService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_services_shared_id = module.SharedResources_appserviceplans.app_plan_backend_services_shared_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_shared_asp_subnet_id        = module.Networking.backend_shared_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  certificate_clientId                = var.certificate_clientId
  certificate_securityGroupId         = var.certificate_securityGroupId
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# AssetAssocation Service
module "asset_association_service" {
  source = "../src/Webapps/assetAssociationService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# Company Service
module "company_service" {
  source = "../src/Webapps/companyService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# device Inventory Service
module "device_inventory_service" {
  source = "../src/Webapps/deviceInventoryService"
  # log_analytics_workspace_id       = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  device_inventory_clientId           = var.device_inventory_clientId
  device_inventory_securityGroupId    = var.device_inventory_securityGroupId
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}


#Email Service
module "email_service" {
  source = "../src/Webapps/emailService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_services_shared_id = module.SharedResources_appserviceplans.app_plan_backend_services_shared_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_shared_asp_subnet_id        = module.Networking.backend_shared_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  front_end_authority                 = module.frontEnd.front_end_authority
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# eventManagementService
module "event_management_service" {
  source = "../src/Webapps/eventManagementService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  user_management_service_authority   = module.user_management_service.user_management_service_authority
}

# event Service
module "event_service" {
  source = "../src/Webapps/eventService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  user_management_service_authority   = module.user_management_service.user_management_service_authority
}

# Asset Service
module "asset_service" {
  source = "../src/Webapps/assetService"
  # log_analytics_workspace_id        = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  user_management_service_authority   = module.user_management_service.user_management_service_authority
}

# User Service
module "user_service" {
  source = "../src/Webapps/userService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix  
}

# pdf generator service
module "pdf_generator_service" {
  source = "../src/Webapps/pdfGeneratorService"
  # log_analytics_workspace_id          = module.monitoring.log_analytics_workspace_id
  app_service_plan_frontend_id        = module.SharedResources_appserviceplans.app_service_plan_frontend_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  frontend_asp_subnet_id              = module.Networking.frontend_asp_subnet_id
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# Simulator
module "Simulator" {
  source = "../src/Webapps/Simulator"
  # log_analytics_workspace_id          = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_services_shared_id = module.SharedResources_appserviceplans.app_plan_backend_services_shared_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_shared_asp_subnet_id        = module.Networking.backend_shared_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}

# user management service
module "user_management_service" {
  source = "../src/Webapps/userManagementService"
  # log_analytics_workspace_id      = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_webapp_id          = module.SharedResources_appserviceplans.app_plan_backend_webapp_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  aspNet_environment                  = var.aspNet_environment
  backend_webapps_asp_subnet_id       = module.Networking.backend_webapps_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
}


# ************* function app *********************
# Allocation function
module "allocation_function" {
  source = "../src/FunctionApps/allocationFunction"
  # log_analytics_workspace_id        = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_services_shared_id = module.SharedResources_appserviceplans.app_plan_backend_services_shared_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  backend_shared_asp_subnet_id        = module.Networking.backend_shared_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  location_environmentPrefix          = var.location_environmentPrefix
  storage_account_access_key          = module.sharedResources_storage.storage_account_access_key
  storage_account_name                = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string   = module.sharedResources_storage.storage_primary_connection_string
}

# Data Ingress Service
module "data_ingress_service" {
  source = "../src/FunctionApps/dataIngressService"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                         = var.acr_login_server
  acr_password                             = var.acr_password
  acr_username                             = var.acr_username
  app_plan_backend_function_id             = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key          = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id           = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name      = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                      = var.environmentLocation
  environmentPrefix                        = var.environmentPrefix
  eventhub_primary_connection_string_input = module.iot_components_eventhub.eventhub_primary_connection_string
  eventhub_primary_connection_string_tsi   = module.iot_components_eventhub.eventhub_primary_connection_string
  key_vault_name                           = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix               = var.location_environmentPrefix
  storage_account_access_key               = module.sharedResources_storage.storage_account_access_key
  storage_account_name                     = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string        = module.sharedResources_storage.storage_primary_connection_string
}

# eventConsumerService
module "event_consumer_service" {
  source = "../src/FunctionApps/eventConsumerService"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                       = var.acr_login_server
  acr_password                           = var.acr_password
  acr_username                           = var.acr_username
  app_plan_backend_function_id           = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key        = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id         = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name    = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                    = var.environmentLocation
  environmentPrefix                      = var.environmentPrefix
  eventhub_dlq_primary_connection_string = module.iot_components_eventhub.eventhub_dlq_primary_connection_string
  eventhub_primary_connection_string     = module.iot_components_eventhub.eventhub_primary_connection_string
  key_vault_name                         = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix             = var.location_environmentPrefix
  storage_account_access_key             = module.sharedResources_storage.storage_account_access_key
  storage_account_name                   = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string      = module.sharedResources_storage.storage_primary_connection_string
}

# export event processor
module "export_event_processor" {
  source = "../src/FunctionApps/exportEventProcessor"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                      = var.acr_login_server
  acr_password                          = var.acr_password
  acr_username                          = var.acr_username
  app_plan_backend_function_id          = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key       = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id        = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name   = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                   = var.environmentLocation
  environmentPrefix                     = var.environmentPrefix
  key_vault_name                        = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix            = var.location_environmentPrefix
  service_bus_primary_connection_string = module.sharedResources_servicebus.service_bus_primary_connection_string
  storage_account_access_key            = module.sharedResources_storage.storage_account_access_key
  storage_account_name                  = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string     = module.sharedResources_storage.storage_primary_connection_string
}

# settings Persistence Service
module "settings_persistence_service" {
  source = "../src/FunctionApps/settingsPersistenceService"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_function_id        = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id      = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  storage_account_access_key          = module.sharedResources_storage.storage_account_access_key
  storage_account_name                = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string   = module.sharedResources_storage.storage_primary_connection_string
  user_management_service_authority   = module.user_management_service.user_management_service_authority  
}

# telemetry Consumer Service
module "telemetry_consumer_service" {
  source = "../src/FunctionApps/telemetryConsumerService"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_function_id        = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id      = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  eventhub_primary_connection_string  = module.iot_components_eventhub.eventhub_primary_connection_string
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  storage_account_access_key          = module.sharedResources_storage.storage_account_access_key
  storage_account_name                = module.sharedResources_storage.storage_account_name
}

# virtual Expression Tester
module "virtual_expression_tester" {
  source = "../src/FunctionApps/virtualExpressionTester"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_function_id        = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id      = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  environmentPrefix                   = var.environmentPrefix
  service_bus_primary_connection_string = module.sharedResources_servicebus.service_bus_primary_connection_string
  location_environmentPrefix          = var.location_environmentPrefix
  storage_account_access_key          = module.sharedResources_storage.storage_account_access_key
  storage_account_name                = module.sharedResources_storage.storage_account_name
  storage_primary_connection_string   = module.sharedResources_storage.storage_primary_connection_string
}

# virtual expression deployment verification
module "virtual_expression_deployment_verification" {
  source = "../src/FunctionApps/virtualExpressionDeploymentVerification"
  # log_analytics_workspace_id             = module.monitoring.log_analytics_workspace_id
  acr_login_server                    = var.acr_login_server
  acr_password                        = var.acr_password
  acr_username                        = var.acr_username
  app_plan_backend_function_id        = module.SharedResources_appserviceplans.app_plan_backend_function_id
  appinsights_instrumentation_key     = module.monitoring.appinsights_instrumentation_key
  backend_function_asp_subnet_id      = module.Networking.backend_function_asp_subnet_id
  backendservices_resource_group_name = module.backend_services_rg.backendservices_resource_group_name
  environmentLocation                 = var.environmentLocation
  eventhub_primary_connection_string  = module.iot_components_eventhub.eventhub_primary_connection_string
  environmentPrefix                   = var.environmentPrefix
  key_vault_name                      = module.sharedResources_keyvault.key_vault_name
  location_environmentPrefix          = var.location_environmentPrefix
  storage_account_access_key          = module.sharedResources_storage.storage_account_access_key
  storage_account_name                = module.sharedResources_storage.storage_account_name  
}