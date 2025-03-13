locals {
  environmentPrefix = var.environmentPrefix
  iothub_name       = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-iot"
  dps_name          = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-dps"
}