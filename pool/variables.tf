variable "name" {
  description = "The name of the Node Pool"
}

variable "zone" {
  description = "In which zone to create the Node Pool"
}

variable "node_count" {
  description = "The number of nodes to create in this Node Pool"
  default     = 3
}

variable "node_count_max" {
  description = "The max number of nodes to create in autoscaling mode"
  default     = 10
}

variable "cluster" {
  description = "Name of the cluster to which to add this Node Pool"
}

variable "oauth_scopes" {
  description = "Oauth scope on Google AMI"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append",
  ]
}

variable "machine_type" {
  description = "The type of machine to use for nodes in the pool"
  default     = "n1-standard-1"
}

variable "disk_type" {
  description = "The type of disk to use for nodes in the pool"
  default     = "pd-ssd"
}

variable "disk_size_gb" {
  description = "Disk of which size to attach to the nodes in the pool "
  default     = "50"
}

variable "image_type" {
  description = "The image type to use for nodes."
  default     = "COS"
}

variable "preemptible" {
  description = "Use preemptible nodes"
  default     = false
}

variable "labels" {
  description = "The Kubernetes labels to be applied to each node"
  type        = map(string)
  default     = {}
}

variable "taint" {
  description = "Add a taint to a node"
  type        = list(string)
  default     = []
}
