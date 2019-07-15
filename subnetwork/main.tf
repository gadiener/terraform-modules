resource "google_compute_subnetwork" "default" {
  provider                 = google
  name                     = var.name
  description              = var.description
  region                   = var.region
  network                  = var.network
  private_ip_google_access = true

  ip_cidr_range = var.cidr_range
  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      ip_cidr_range = lookup(secondary_ip_range.value, "ip_cidr_range", null)
      range_name    = lookup(secondary_ip_range.value, "range_name", null)
    }
  }
}
