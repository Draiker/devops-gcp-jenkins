resource "google_compute_firewall" "jenkins" {
  name = "${var.firewall_name}"
  network = "${var.firewall_network}"

  allow {
    protocol = "tcp"
    ports = ["22", "80", "8080", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
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
    network    = "default"
    access_config {

    }
  }
  metadata {
    ssh-keys = "draiker_ds:${file("${var.public_key_path}")}"
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  provisioner "file" {
    source = "scripts/startup.centos-7.sh"
    destination = "/tmp/startup.centos-7.sh"

    connection {
      type = "ssh"
      user = "draiker_ds"
      private_key = "${file("${var.private_key_path}")}"
      agent = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "draiker_ds"
      private_key = "${file("${var.private_key_path}")}"
      agent = false
    }

    inline = [
      "chmod +x /tmp/startup.centos-7.sh",
      "/tmp/startup.centos-7.sh"
    ]
  }
}