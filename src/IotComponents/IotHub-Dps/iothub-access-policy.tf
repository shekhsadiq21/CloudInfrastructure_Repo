resource "azurerm_iothub_shared_access_policy" "full_accesspolicy" {
  name                = "FullAccessPolicy"
  resource_group_name = var.iotcomponents_resource_group_name
  iothub_name         = azurerm_iothub.IOTHUB.name

  registry_read   = true
  registry_write  = true
  service_connect = true
  device_connect  = true
}