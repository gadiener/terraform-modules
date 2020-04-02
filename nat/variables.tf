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

variable "min_ports_per_vm" {
  description = "Minimum number of ports allocated to a VM"
  default = "64"
}

variable "tcp_established_idle_timeout_sec" {
  description = "Timeout in seconds for TCP established connections"
  default = 1200
}

variable "tcp_transitory_idle_timeout_sec" {
  description = "Timeout in seconds for TCP transitory connections"
  default = 30
}

variable "udp_idle_timeout_sec" {
  description = "Timeout in seconds for UDP"
  default = 30
}

variable "icmp_idle_timeout_sec" {
  description = "Timeout in seconds for ICMP"
  default = 30
}

variable "address_count" {
  description = "Address count"
  default     = 1
}

variable "enable_error_log" {
  description = "Enable error log"
  default     = true
}
