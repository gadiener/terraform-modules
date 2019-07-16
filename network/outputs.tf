output "network" {
  value = google_compute_network.default.name
}

output "network_link" {
  value = google_compute_network.default.self_link
}
