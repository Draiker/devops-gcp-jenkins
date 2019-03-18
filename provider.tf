provider "google" {
  credentials = "${file(".credentials/DevOps-Project-c564ff665490.json")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
  zone        = "${var.region}-${var.zone}"
}
