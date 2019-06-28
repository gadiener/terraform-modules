resource "google_compute_subnetwork" "default" {
	provider 									= "google"
  name                      = "${var.name}"
  description               = "${var.description}"
  region                    = "${var.region}"
  network                   = "${var.network}"
  private_ip_google_access  = true

	ip_cidr_range 						= "${var.cidr_range}"
	secondary_ip_range 				= "${var.secondary_ip_ranges}"
}