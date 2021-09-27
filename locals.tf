resource "random_id" "id" {
  byte_length = 8
}

locals {
  kube_cluster_name = "my"
  
  kube_control_plane_count    = 1
  kube_control_plane_hostname = "${local.kube_cluster_name}-control-plane-${random_id.id.hex}"

  kube_worker_count    = 1
  kube_worker_hostname = "${local.kube_cluster_name}-worker-${random_id.id.hex}"

  hetzner_worker_server_type = "cx21"
  hetzner_control_plane_type = "cx21"
  hetzner_image              = "ubuntu-20.04"
  hetzner_datacenter         = "nbg1"
  hetzner_ssh_user           = "root"

  ip_range     = "192.168.0.0/16"
  network_zone = "eu-central"
  domain       = "uwannah.com"
}