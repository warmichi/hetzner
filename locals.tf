locals {
  kube_cluster_name = "my"

  kube_control_plane_count = 3
  kube_worker_count        = 2

  hetzner_worker_server_type = "cx21"
  hetzner_control_plane_type = "cpx11"
  hetzner_image              = "ubuntu-20.04"
  hetzner_datacenter         = "nbg1"
  hetzner_ssh_user           = "root"

  ip_range     = "192.168.0.0/16"
  network_zone = "eu-central"
  domain       = "uwannah.com"
}