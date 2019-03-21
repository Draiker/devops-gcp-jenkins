variable "gcp_project" {
  default = "draiker-devops-project-if-095"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "instance_type" {
  default = "f1-micro"
}

variable "os-image" {
  default = "centos-7-v20190213"
}
variable "instance_name" {
  default = "ac-instance"
}

// Network Variables
variable "network_name" {
  default = "devops-network"
}
variable "network_cidr" {
  default = "10.128.0.0/24"
}

// FIREWALL Variables
variable "firewall_name" {
  default = "ac-jenkins"
}
variable "firewall_network" {
  default = "default"
}

variable "public_key_path" {
  default = ".credentials/key public OpenSSH.pub"
}
variable "private_key_path" {
  default = ".credentials/key private OpenSSH.pem"
}

