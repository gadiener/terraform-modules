variable "name" {
  description = "Subnetwork name"
}

variable "description" {
  description = "Subnetwork description"
	default = ""
}

variable "region" {
  description = "Subnetwork region"
}

variable "network" {
  description = "Subnetwork parent network"
}

variable "cidr_range" {
  description = "Subnetwork ip cidr range"
}

variable "secondary_ip_ranges" {
  description = "Subnetwork secondary ip cidr ranges"
	type = "list"
	default = []
}
