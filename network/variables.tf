variable "name" {
  description = "Network name"
}

variable "description" {
  description = "Network description"
  default     = ""
}

variable "auto_create_subnetworks" {
  description = "Auto create subnetworks"
  default     = false
}
