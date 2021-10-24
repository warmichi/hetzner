resource "hcloud_ssh_key" "root" {
  name       = var.kube_cluster_name
  public_key = var.hcloud_ssh_root_public_key
}

resource "hcloud_network" "network" {
  name     = var.kube_cluster_name
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "network_subnet" {
  network_id   = hcloud_network.network.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = var.ip_range
}

resource "hcloud_server" "kube_control_plane" {
  count       = var.kube_control_plane_count
  name        = "${var.kube_cluster_name}-control-plane-${count.index + 1}"
  server_type = var.hetzner_control_plane_type
  image       = var.hetzner_image
  location    = var.hetzner_datacenter
  user_data   = data.template_file.cloud_init.rendered

  network {
    network_id = hcloud_network.network.id
  }

  ssh_keys = [
    hcloud_ssh_key.root.id
  ]

  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.network_subnet
  ]
}

resource "hcloud_server" "kube_node" {
  count       = var.kube_node_count
  name        = "${var.kube_cluster_name}-node-${count.index + 1}"
  server_type = var.hetzner_node_server_type
  image       = var.hetzner_image
  location    = var.hetzner_datacenter
  user_data   = data.template_file.cloud_init.rendered

  network {
    network_id = hcloud_network.network.id
  }

  ssh_keys = [
    hcloud_ssh_key.root.id
  ]

  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.network_subnet
  ]

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      chmod 600 ${var.hcloud_ssh_root_private_key}
      ansible-playbook -i ${path.root}/inventory remove-node.yml -b -v --extra-vars "node=${self.name}"
    EOT
  }
}
