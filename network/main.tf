resource "google_compute_network" "default" {
  provider                = google
  name                    = var.name
  description             = var.description
  project                 = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
}

module "icmp-access" {
  source = "../firewall/ingress-allow"

  name        = "access-${var.name}-icmp"
  description = "Access for internet control message protocol"
  network     = var.name
  project_id  = var.project_id

  allow = [
    {
      protocol = "icmp"
    },
  ]

  source_ranges = ["0.0.0.0/0"]
}
