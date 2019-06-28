variable "name" {
  description = "The name of the cluster, unique within the project and zone"
}

variable "description" {
  description = "Cluster description"
	default     = "K8s cluster"
}

variable "min_master_version" {
  description = "Minimum kubernetes master version"
	default     = "1.12.6-gke.11"
}

variable "master_ipv4_cidr_block" {
	description = "Master IPv4 cidr block"
	default     = "172.16.0.0/28"
}

variable "enable_private_master" {
	description = "Enable private master endpoint"
	default     = true
}

variable "zone" {
  description = "The zone the master and nodes specified in initial_node_count should be created in"
}

variable "additional_zones" {
  description = "The node pools will be replicated automatically to the additional zones"
	type = "list"
	default = []
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected"
}

variable "subnetwork" {
	description = "The name or self_link of the Google Compute Engine subnetwork to which the cluster is connected"
}

variable "istio" {
	description = "Enable istio"
	default = false
}

variable "pods_range_name" {
	description = "Network range for pods"
}

variable "services_range_name" {
	description = "Network range for services"
}

variable "cluster_autoscaling" {
	description = "Cluster autoscaling config"
	type = "list"

	default = [
		{
			enabled = true,
			resource_limits = [
				{
					resource_type = "cpu"
					minimum = 2
					maximum = 200
				},
				{
					resource_type = "memory"
					minimum = 8
					maximum = 400
				}
			]
		}
	]
}

variable "pod_security_policy_config" {
	description = "Enable pod security policy"
	default = false
}

variable "master_authorized_networks_cidr" {
	description = "Master authorized cidr blocks"
	type = "list"

	default = [
			{
			cidr_block 		= "10.0.0.0/8"
			display_name 	= "internal"
		}
	]
}

variable "labels" {
	description = "The Kubernetes labels to be applied to cluster resources"
	type = "map"
	default = {}
}