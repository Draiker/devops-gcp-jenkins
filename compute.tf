resource "google_compute_firewall" "ac-jenkins" {
  name = "${var.firewall_name}"
  network = "${var.firewall_network}"

  allow {
    protocol = "tcp"
    ports = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_subnetwork" "default" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "${var.network_cidr}"
  network                  = "${google_compute_network.default.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = true
}
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  machine_type = "${var.instance_type}"
  zone         = "${var.zone}"
  tags = ["jenkins", "ansible"]

  boot_disk {
    initialize_params {
      image = "${var.os-image}"
    }
  }

  network_interface {
    subnetwork    = "${google_compute_subnetwork.default.name}"
    access_config {

    }
  }
  #metadata_startup_script = "${file("./startup.centos-7.sh")}"
}