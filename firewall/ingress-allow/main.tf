resource "google_compute_firewall" "default" {
	provider    = "google"
  name        = "${var.name}"
  description = "${var.description}"
  network     = "${var.network}"
  priority    = "${var.priority}"

  allow = "${var.allow}"

  source_ranges = ["${var.source_ranges}"]
  target_tags   = "${var.target_tags}"
  source_tags   = "${var.source_tags}"
}
