# purpose - static dev environment used for all the wencoCloud development teams
# defining values to variables

# name of the environmet 
environmentPrefix = "uat"
# possible values "Development, qa, uat, Prod"
aspNet_environment = "uat"

# react app env name
react_app_env = "uat"

# select the location to deploy envi
environmentLocation        = "Central US"
location_environmentPrefix = "cus"


# subscription Id
subscription_id = "853d8c0b-d3b2-4737-914d-47676bbc47ca"

#vpn Ipaddress 
rsystems_vpn1_startip_address  = "103.219.215.0"
rsystems_vpn1_endip_address    = "103.219.215.255"
rsystems_vpn2_startip_address  = "203.34.117.0"
rsystems_vpn2_endip_address    = "203.34.117.255"
wenco_vpn_startip_address      = "64.16.56.194"
wenco_vpn_endip_address        = "64.16.56.194"
# vpn Ipaddress block
rsystems_vpn1_ipaddress      = "103.219.215.0/24"
rsystems_vpn2_ipaddress      = "203.34.117.0/24"
azure_devops_ipaddress       = "52.228.82.0/24"
wenco_vpn_ipaddress          = "64.16.56.194/32"

# Networking:
## Pick a number which is not in use from the page and update the document accordingly
## https://wencosupport.atlassian.net/wiki/spaces/WL/pages/4658102397/Azure+Vnet+IpAddress+Schema

## EnvironmentNetClass: a number in this set: {10,172}.  
## This will allow the environments to be deployed in the 10.0.0.0/8 or 172.16.0.0/12 private subnets.
EnvironmentNetClass = "10"

## EnvironmentNet: a number between 1 and 250 (but not 80,90,91) that will be used to use different IPv4 ranges
EnvironmentNet = "3"


# ************ app service plans *********************
# app service plan for frontend
frontend_appserviceplan_tier = "Standard"
frontend_appserviceplan_size = "S1"

# app service plan for backend webapps
backend_webapp_appserviceplan_tier = "PremiumV3"
backend_webapp_appserviceplan_size = "P2v3"

# app service plan for fucntion apps
backend_function_appserviceplan_tier = "PremiumV2"
backend_function_appserviceplan_size = "P1v2"

# # app service plan for backend shared services
backend_services_shared_appserviceplan_tier = "Standard"
backend_services_shared_appserviceplan_size = "S1"


# APIM
# Look for possible SKu - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management#:~:text=of%20publisher/company.-,sku_name,--%20(Required)%20sku_name%20is
# Change this SKU to Basic_1 for UAT and Prod once APIM is used by more services
EnvironmentSKU_Apim = "Developer_1"

# Iot hub scale and Number of units
sku_name     = "S1"
sku_capacity = "5"


# sql db
# asset association service
asset_association_service_sql_db_edition                            = "Standard"
asset_association_service_requested_service_objective_name          = "S0"
# company service
company_service_sql_db_edition                                      = "Standard"
company_service_requested_service_objective_name                    = "S0"
# device inventory
device_inventory_sql_db_edition                                     = "Standard"
device_inventory_requested_service_objective_name                   = "S0"
# event management
event_management_sql_db_edition                                     = "Standard"
event_management_requested_service_objective_name                   = "S3"
# event service  
event_service_sql_db_edition                                        = "Standard"
event_service_requested_service_objective_name                      = "S3"
# asset service  
asset_service_sql_db_edition                                        = "Standard"
asset_service_requested_service_objective_name                      = "S0"
# user service  
user_service_sql_db_edition                                         = "Standard"
user_service_requested_service_objective_name                       = "S0"

# postgres sku's
postgresql_sku      = "B_Gen5_1"
postgresql_version  = "11"    
postgresql_storage  = "5120"

# spiceDB container cores and memory
authorizationdb_cpu  = "1"
authorizationdb_memory = "1.5"

# Azure Security Group - This group is used for providing acess for users to run device provisiong tool in Non-Prod environments.
certificate_securityGroupId      = "6cbbc247-becb-4bf7-94c2-65681b52152d"
device_inventory_securityGroupId = "6cbbc247-becb-4bf7-94c2-65681b52152d"
# clientID - Application client ID from App registrations.
# Application ID & Secrets are stored in wcp-sh-wus2-appreg-kv (keyVault)
certificate_clientId      = "ba44f511-e115-4781-80c9-ca91b3e0c46c"
device_inventory_clientId = "36103992-3a40-4552-a5f0-513273e193cd"

#Auth0 url and automated testing app IDs
auth0_tenant_url = "https://uat-wenco.us.auth0.com"
auth0_automation_clientId = "placeholder"