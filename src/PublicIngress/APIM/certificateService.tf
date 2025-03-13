resource "azurerm_api_management_api" "certificate_service" {
  name                = "certificate_service"
  resource_group_name = var.public_ingress_resource_group_name
  api_management_name = local.apim_name
  revision            = "1"
  display_name        = "Certificate Service API"
  path                = "certificates"
  protocols           = ["https"]
  service_url         = var.certificate_service_base_url 
}

resource "azurerm_api_management_api_operation" "certificate_service_wildcards" {
  for_each            = local.wildcard_operations
  operation_id        = "wildcard-${lower(each.key)}"
  api_name            = azurerm_api_management_api.certificate_service.name
  api_management_name = local.apim_name
  resource_group_name = var.public_ingress_resource_group_name
  display_name        = "Wildcard ${each.key}"
  method              = each.key
  url_template        = "/*"
  description         = "Wildcard ${each.key} operation"
}