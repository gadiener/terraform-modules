variable "name" {
  description = "The name of the firewall rule"
}

variable "description" {
  description = "The description of the firewall rule"
}

variable "network" {
  description = "The network this firewall rule applies to"
}

variable "priority" {
  description = "The firewall rule priority"
  default     = "1000"
}

variable "allow" {
  description = "The protocol and port to allow"
  type        = list
  default     = []
}

variable "source_ranges" {
  description = "A list of source CIDR ranges that this firewall applies to"
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "A list of source tags for this firewall rule"
  type        = list
  default     = []
}

variable "target_tags" {
  description = "A list of target tags for this firewall rule"
  type        = list
  default     = []
}
