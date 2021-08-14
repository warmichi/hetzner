resource "hcloud_ssh_key" "rancher" {
  name       = local.rancher_cluster_name
  public_key = var.HCLOUD_SSH_RANCHER_PUBLIC_KEY
}

resource "hcloud_network" "network" {
  name     = local.rancher_cluster_name
  ip_range = local.ip_range
}

resource "hcloud_network_subnet" "network_subnet" {
  network_id   = hcloud_network.network.id
  type         = "server"
  network_zone = local.network_zone
  ip_range     = local.ip_range
}

resource "hcloud_server" "rancher" {
  count       = local.rancher_node_count
  name        = "${local.rancher_cluster_name}-${count.index + 1}"
  server_type = local.hetzner_server_type
  image       = local.hetzner_image
  location    = local.hetzner_datacenter
  user_data   = data.template_file.cloud_init.rendered

  network  {
    network_id = hcloud_network.network.id
    
  }

  ssh_keys = [
    hcloud_ssh_key.rancher.id,
  ]
}
