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
  count       = local.rancher_node_count
  name        = "${var.cluster_name}-${count.index + 1}"
  server_type = var.rancher-mgmt
  image       = var.image
  location    = var.datacenter
  user_data   = data.template_file.cloud_init.rendered

  ssh_keys = [
    hcloud_ssh_key.rancher.id,
  ]
}

resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_server.rancher[0].id
  network_id = hcloud_network.net.id
}


########################################
### Wait for docker install on nodes
########################################
resource "null_resource" "wait_for_docker" {
  count = local.rancher_node_count

  triggers = {
    instance_ids = join(",", concat(hcloud_server.rancher.*.id))
  }

  provisioner "local-exec" {
    command = <<EOF
while [ "$${RET}" -gt 0 ]; do
    ssh -q -o StrictHostKeyChecking=no -i $${KEY} $${USER}@$${IP} 'docker ps 2>&1 >/dev/null'
    RET=$?
    if [ "$${RET}" -gt 0 ]; then
        sleep 10
    fi
done
EOF


    environment = {
      RET  = "1"
      USER = "root"
      IP   = element(concat(hcloud_server.rancher.*.ipv4_address), count.index)
      KEY  = "${var.HCLOUD_SSH_RANCHER_PRIVATE_KEY}"
    }
  }
}