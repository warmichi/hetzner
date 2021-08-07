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

########################################
### Wait for docker install on nodes
########################################
resource "null_resource" "wait_for_docker" {
  count = local.master_node_count

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
      IP   = element(concat(hcloud_server.rancher.*.public_ip), count.index)
      KEY  = "${path.root}/outputs/id_rsa"
    }
  }
}