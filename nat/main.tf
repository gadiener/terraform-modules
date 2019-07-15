resource "google_compute_router" "router" {
  provider = google

  name    = var.name
  region  = var.region
  network = var.network
  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "address" {
  provider = google

  count  = var.address_count
  name   = "${var.name}-nat-address-${count.index}"
  region = var.region
}

resource "google_compute_router_nat" "router-nat" {
  provider = google

  name                               = "${var.name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.address.*.self_link
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnetwork
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
