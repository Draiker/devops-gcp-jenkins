variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "c"
}
variable "os-image" {
  default = "centos-7-v20190213"
}

resource "google_compute_firewall" "tcp-firewall-rule-8080" {
  name = "tcp-firewall-rule-8080"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}

provider "google" {
  credentials = "${file(".credentials/DevOps-Project-c564ff665490.json")}"
  project     = "draiker-devops-project-if-095"
  region      = "${var.region}"
  zone        = "${var.region}-${var.zone}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "ac-instance"
  machine_type = "f1-micro"
  tags = ["jenkins", "ansible"]

  boot_disk {
    initialize_params {
      image = "${var.os-image}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }
  #metadata_startup_script = "${file("./startup.centos-7.sh")}"
}