resource "azurerm_api_management_api" "pdf_generator_service" {
  name                = "pdf_generator_service"
  resource_group_name = var.public_ingress_resource_group_name
  api_management_name = local.apim_name
  revision            = "1"
  display_name        = "PDF Generator Service API"
  path                = "pdf"
  protocols           = ["https"]
  service_url         = var.pdf_generator_service_base_url 
}

resource "azurerm_api_management_api_operation" "pdf_generator_service_wildcards" {
  for_each            = local.wildcard_operations
  operation_id        = "wildcard-${lower(each.key)}"
  api_name            = azurerm_api_management_api.pdf_generator_service.name
  api_management_name = local.apim_name
  resource_group_name = var.public_ingress_resource_group_name
  display_name        = "Wildcard ${each.key}"
  method              = each.key
  url_template        = "/*"
  description         = "Wildcard ${each.key} operation"
}