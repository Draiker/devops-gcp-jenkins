/*
output "public_ip_master" {
  value = ["${google_compute_instance.ac-instance.*.network_interface.0.access_config.0.nat_ip}"]
}
*/