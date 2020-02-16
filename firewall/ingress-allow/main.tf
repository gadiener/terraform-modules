resource "google_compute_firewall" "default" {
  provider    = google
  name        = var.name
  description = var.description
  network     = var.network
  priority    = var.priority
  project     = var.project_id

  dynamic "allow" {
    for_each = var.allow
    content {
      ports    = lookup(allow.value, "ports", null)
      protocol = allow.value.protocol
    }
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
  source_tags   = var.source_tags
}
