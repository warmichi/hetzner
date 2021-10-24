resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id, hcloud_server.kube_node.*.id),
    kube_version      = var.kube_version
  }

  provisioner "local-exec" {
    command = <<EOT
      chmod 600 ${var.hcloud_ssh_root_private_key}
      sleep 60

      # Bootstrap cluster when enviroment variable is set 
      if [ "$BOOTSTRAP_KUBE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/cluster.yml -e kube_version=${var.kube_version}
      fi

      # Scale cluster when enviroment variable is set 
      if [ "$SCALE_KUBE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/scale.yml
      fi

      # Graceful Upgrade Cluster when enviroment variable is set
      if [ "$UPGRADE_KUBE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/upgrade-cluster.yml -e kube_version=${var.kube_version}
      fi

      # Destroy nodes
      if test -f "destroyed_nodes"; then
        ansible-playbook -i ${path.root}/inventory /kubespray/remove-node.yml -e allow_ungraceful_removal=true -e reset_nodes=false -e node="$(cat destroyed_nodes | sed 's/^\|$//g'|paste -sd, - )"
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
