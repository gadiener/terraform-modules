variable "name" {
  description = "Router name"
}

variable "region" {
  description = "Router region"
}

variable "network" {
  description = "Router network"
}

variable "subnetwork" {
  description = "Router subnetwork link"
}


variable "address_count" {
	description = "Address count"
	default = 1
}