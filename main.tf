resource "hcloud_ssh_key" "rancher" {
  name       = var.cluster_name
  public_key = var.HCLOUD_SSH_RANCHER_PUBLIC_KEY
}

resource "hcloud_network" "net" {
  name     = var.cluster_name
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "rancher" {
  network_id   = hcloud_network.net.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = var.ip_range
}

resource "hcloud_server" "rancher" {
  count       = 1
  name        = "${var.cluster_name}-${count.index + 1}"
  server_type = var.rancher-mgmt
  image       = var.image
  location    = var.datacenter
  user_data   = data.template_file.cloud_init.rendered

  ssh_keys = [
    hcloud_ssh_key.rancher.id,
  ]
}