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
  name        = local.rancher_hostname
  server_type = local.hetzner_server_type
  image       = local.hetzner_image
  location    = local.hetzner_datacenter
  user_data   = data.template_file.cloud_init.rendered

  network {
    network_id = hcloud_network.network.id

  }

  ssh_keys = [
    hcloud_ssh_key.rancher.id,
  ]

  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.network_subnet
  ]
}

resource "null_resource" "wait_for_rancher" {
  provisioner "local-exec" {
    command = <<EOF
while [ "$${resp}" != "pong" ]; do
    resp=$(curl -sSk -m 2 "https://$${RANCHER_HOSTNAME}:8443/ping")
    echo "Rancher Response: $${resp}"
    if [ "$${resp}" != "pong" ]; then
      sleep 10
    fi
done
EOF


    environment = {
      RANCHER_HOSTNAME = "${local.rancher_hostname}.${local.domain}"
    }
  }
  depends_on = [
    hetznerdns_record.rancher
  ]
}