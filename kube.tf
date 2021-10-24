resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id, hcloud_server.kube_node.*.id),
    kube_version      = var.kube_version
  }

  provisioner "local-exec" {
    command = <<EOT
      chmod 600 ${var.hcloud_ssh_root_private_key}
      sleep 60

      # Bootstrap or scale cluster when enviroment variable is set 
      if [ "$SCALE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/scale.yml
      else
        ansible-playbook -i ${path.root}/inventory /kubespray/cluster.yml -e kube_version=${var.kube_version}
      fi

      # Graceful Upgrade Cluster when enviroment variable is set
      if [ "$UPGRADE_CLUSTER" = true ] ; then
        ansible-playbook -i ${path.root}/inventory /kubespray/upgrade-cluster.yml -e kube_version=${var.kube_version}

      # Destroy nodes
      if test -f "destroyed_nodes"; then
        ansible-playbook -i ${path.root}/inventory /kubespray/remove-node.yml -b -v --extra-vars reset_nodes=false "node=$(cat destroyed_nodes | sed 's/^\|$//g'|paste -sd, - )"
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
