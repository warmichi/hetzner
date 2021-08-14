resource "hcloud_ssh_key" "rancher" {
  name       = local.cluster_name
  public_key = var.HCLOUD_SSH_RANCHER_PUBLIC_KEY
}

resource "hcloud_network" "net" {
  name     = local.cluster_name
  ip_range = local.ip_range
}

resource "hcloud_network_subnet" "rancher" {
  network_id   = hcloud_network.net.id
  type         = "server"
  network_zone = local.network_zone
  ip_range     = local.ip_range
}

resource "hcloud_server" "rancher" {
  count       = local.rancher_node_count
  name        = "${local.cluster_name}-${count.index + 1}"
  server_type = local.hetzner_server_type
  image       = local.image
  location    = local.datacenter
  user_data   = data.template_file.cloud_init.rendered

  ssh_keys = [
    hcloud_ssh_key.rancher.id,
  ]#
}

resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_server.rancher[0].id
  network_id = hcloud_network.net.id
}
