resource "random_id" "id" {
  byte_length = 8
}

locals {
  k8s_cluster_name        = "first"
  k8s_control_plane_count = 1
  k8s_hostname            = "${local.k8s_cluster_name}-${random_id.id.hex}"

  hetzner_server_type = "cx21"
  hetzner_image       = "ubuntu-20.04"
  hetzner_datacenter  = "nbg1"
  hetzener_ssh_user   = "root"

  ip_range     = "192.168.0.0/16"
  network_zone = "eu-central"
  domain       = "uwannah.com"
}