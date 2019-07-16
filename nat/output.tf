output "address" {
  value = google_compute_address.address.*.address
}

output "address_count" {
  value = var.address_count
}
