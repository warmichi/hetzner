resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id, hcloud_server.kube_node.*.id),
    kubespray_config      = jsonencode(local.kubespray_config)
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 60

      # Bootstrap cluster when enviroment variable is set 
      if [ "$BOOTSTRAP_KUBE_CLUSTER" = true ] ; then
        echo "Bootstrap Kube Cluster ..."
        ansible-playbook -i ${path.root}/inventory /kubespray/cluster.yml -e '${jsonencode(local.kubespray_config)}' -e hcloud_api_token=$TF_VAR_hcloud_token
      fi

      # Scale cluster when enviroment variable is set 
      if [ "$SCALE_KUBE_CLUSTER" = true ] ; then
        echo "Scale Kube Cluster ..."
        ansible-playbook -i ${path.root}/inventory /kubespray/scale.yml
      fi

      # Graceful Upgrade Cluster when enviroment variable is set
      if [ "$UPGRADE_KUBE_CLUSTER" = true ] ; then
        echo "Upgrade Kube Cluster ..."
        ansible-playbook -i ${path.root}/inventory /kubespray/upgrade-cluster.yml -e '${jsonencode(local.kubespray_config)}
      fi

      # Remove Kube-Nodes
      if test -f "destroyed_nodes"; then
        echo "Remove Kube Nodes ..."
        destroyed_nodes=$(cat destroyed_nodes | sed 's/^\|$//g'|paste -sd, - )
        ansible-playbook -i ${path.root}/inventory -i $destroyed_nodes /kubespray/remove-node.yml \
        -e node=$destroyed_nodes -e reset_nodes=false -e allow_ungraceful_removal=true -e skip_confirmation=true      
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
