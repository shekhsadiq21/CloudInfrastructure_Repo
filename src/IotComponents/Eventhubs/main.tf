locals {
  environmentPrefix      = var.environmentPrefix
  eventhub_namespace     = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-evh"
  eventhub_namespace_dlq = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-dlq-evh"
}