resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id, hcloud_server.kube_node.*.id),
    kube_version      = var.kube_version
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 60 && ansible-playbook -i ${path.root}/inventory /kubespray/cluster.yml -e kube_version=${var.kube_version}
      if [ "$SCALE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/scale.yml
      fi
    EOT

    environment = {
      ANSIBLE_PRIVATE_KEY_FILE  = "${var.hcloud_ssh_root_private_key}"
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  depends_on = [
    hetznerdns_record.kube_control_plane,
    hcloud_server.kube_control_plane,
    hetznerdns_record.kube_node,
    hcloud_server.kube_node
  ]
}
