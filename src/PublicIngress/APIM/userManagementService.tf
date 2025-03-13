 resource "azurerm_api_management_api" "user_management_service" {
  name                = "user_management_service"
  resource_group_name = var.public_ingress_resource_group_name
  api_management_name = local.apim_name
  revision            = "1"
  display_name        = "User Management Service API"
  path                = "userManagement"
  protocols           = ["https"]
  service_url         = var.user_management_service_base_url
}

resource "azurerm_api_management_api_operation" "user_management_service_wildcards" {
  for_each            = local.wildcard_operations
  operation_id        = "wildcard-${lower(each.key)}"
  api_name            = azurerm_api_management_api.user_management_service.name
  api_management_name = local.apim_name
  resource_group_name = var.public_ingress_resource_group_name
  display_name        = "Wildcard ${each.key}"
  method              = each.key
  url_template        = "/*"
  description         = "Wildcard ${each.key} operation"
}