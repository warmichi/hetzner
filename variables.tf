variable "cluster_name" {
  description = "prefix for cloud resources"
  default     = "rancher-mgmt"
}

variable "rancher_version" {
  default = "2.5.9"
}

variable "RANCHER_UI_PASSWORD" {
}

variable "kubernetes_version" {
  default = "1.21"
}

variable "HCLOUD_SSH_RANCHER_PUBLIC_KEY" {
  description = "SSH public key file"
}

variable "HCLOUD_SSH_RANCHER_PRIVATE_KEY_FILE" {
  description = "SSH private key file used to access instances"
}

variable "ssh_username" {
  default = "root"
}

# Provider specific settings

variable "rancher-mgmt" {
  default = "cx21"
}

variable "datacenter" {
  default = "nbg1"
}

variable "image" {
  default = "ubuntu-20.04"
}

variable "ip_range" {
  default     = "192.168.0.0/16"
  description = "ip range to use for private network"
}

variable "network_zone" {
  default     = "eu-central"
  description = "network zone to usefor private network"
}
