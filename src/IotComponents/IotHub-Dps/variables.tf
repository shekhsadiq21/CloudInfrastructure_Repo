variable "iotcomponents_resource_group_name" {
  description = "Name of the resource group to deploy"
  type        = string
}

variable "environmentLocation" {
  description = "Region to deploy resources into"
  type        = string
  default     = ""
}

variable "environmentPrefix" {
  description = "environment prefix"
  type        = string
  default     = ""
}
variable "location_environmentPrefix" {
  description = "location environmentPrefix"
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "sku name"
  type        = string
  default     = ""
}

variable "sku_capacity" {
  description = "sku name"
  type        = string
  default     = ""
}

#event hub 
variable "eventhub_eventdata_iothub_rule" {
  description = "eventhub eventdata iothub rule"
  type        = string
  default     = ""
}

variable "eventhub_telemetrydata_iothub_rule" {
  description = "eventhub telemetrydata iothub rule"
  type        = string
  default     = ""
}

variable "eventhub_sensordata_gen2_rule" {
  description = "eventhub sensordata gen2 rule"
  type        = string
  default     = ""
}

variable "eventhub_msgcapture_rule" {
  description = "eventhub msgcapture rule"
  type        = string
  default     = ""
}
