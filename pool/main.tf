resource "google_container_node_pool" "pool" {
  provider           = google-beta
  name               = var.name
  location           = var.zone
  cluster            = var.cluster
  initial_node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.node_count
    max_node_count = var.node_count_max
  }

  node_config {
    image_type   		= "COS"
    machine_type 		= "${var.machine_type}"
    disk_size_gb 		= "${var.disk_size_gb}"
		disk_type 			= "${var.disk_type}"
		local_ssd_count = "${var.local_ssd_count}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    preemptible = var.preemptible
    dynamic "taint" {
      for_each = var.taint
      content {
        effect = taint.value.effect
        key    = taint.value.key
        value  = taint.value.value
      }
    }

    labels = var.labels

    oauth_scopes = var.oauth_scopes

    tags = ["${var.cluster}-cluster", "${var.name}-pool", "nodes"]
  }
}
