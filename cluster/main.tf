resource "google_container_cluster" "cluster" {
	provider = "google-beta"

	name = "${var.name}"
    description = "${var.description}"
    location = "${var.zone}"
	node_locations = "${var.additional_zones}"
	network = "${var.network}"
	subnetwork = "${var.subnetwork}"
	min_master_version = "${var.min_master_version}"

	remove_default_node_pool = true
	initial_node_count = 1

	logging_service = "logging.googleapis.com/kubernetes"
	monitoring_service = "monitoring.googleapis.com/kubernetes"

	cluster_autoscaling = "${var.cluster_autoscaling}"

	ip_allocation_policy {
		use_ip_aliases = true
		cluster_secondary_range_name = "${var.pods_range_name}"
		services_secondary_range_name = "${var.services_range_name}"
	}

	# Setting an empty username and password explicitly disables basic auth
	master_auth {
    username = ""
    password = ""
		client_certificate_config {
			issue_client_certificate = false
		}
	}

	pod_security_policy_config {
		enabled = "${var.pod_security_policy_config}"
	}

	master_authorized_networks_config {
		cidr_blocks = "${var.master_authorized_networks_cidr}"
	}

	enable_legacy_abac = false

	network_policy {
		enabled = true
		provider = "CALICO"
	}

	private_cluster_config {
		enable_private_endpoint = "${var.enable_private_master}"
		enable_private_nodes 		= true
		master_ipv4_cidr_block 	= "${var.master_ipv4_cidr_block}"
	}

	maintenance_policy {
		daily_maintenance_window {
			start_time = "00:00"
		}
	}

  vertical_pod_autoscaling {
    enabled = true
  }

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }
    istio_config {
      disabled = "${!var.istio}"
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    cloudrun_config {
      disabled = true
    }
  }

	resource_labels = "${var.labels}"
}









