output "subnetwork" {
  value = google_compute_subnetwork.default.name
}

output "subnetwork_link" {
  value = google_compute_subnetwork.default.self_link
}

output "ip_cidr_range" {
  value = google_compute_subnetwork.default.ip_cidr_range
}
