resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id, hcloud_server.kube_node.*.id),
    kubespray_config  = jsonencode(local.kubespray_config)
  }

  provisioner "local-exec" {
    command = <<EOT
          
      # append argocd bootstrap task
      # cat ${path.root}/files/argocd_bootstrap_playbook_task.yml >> /kubespray/roles/kubernetes-apps/argocd/tasks/main.yml
           
      # sleep workaround for unready resources
      sleep 60
      
      cd /kubespray

      # Bootstrap cluster when enviroment variable is set 
      echo $BOOTSTRAP_KUBE_CLUSTER
      if [ "$BOOTSTRAP_KUBE_CLUSTER" = true ] ; then
        echo "Bootstrap Kube Cluster ..."
        ansible-playbook -i /kubespray/inventory/kube-1/inventory.ini /kubespray/cluster.yml -e $KUBESPRAY_CONFIG -b
      fi

      # Scale cluster when enviroment variable is set 
      if [ "$SCALE_KUBE_CLUSTER" = true ] ; then
        echo "Scale Kube Cluster ..."
        ansible-playbook -i ${path.root}/inventory /kubespray/scale.yml -e $KUBESPRAY_CONFIG
      fi

      # Graceful Upgrade Cluster when enviroment variable is set
      if [ "$UPGRADE_KUBE_CLUSTER" = true ] ; then
        echo "Upgrade Kube Cluster ..."
        ansible-playbook -i ${path.root}/inventory /kubespray/upgrade-cluster.yml -e $KUBESPRAY_CONFIG
      fi        
    EOT

    environment = {
      ANSIBLE_PRIVATE_KEY_FILE  = "${var.HCLOUD_SSH_WARMICHI_PRIVATE_KEY}"
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_REMOTE_USER = "warmichi"
      ANSIBLE_SSH_ARGS = "-o UserKnownHostsFile=/dev/null"
      KUBESPRAY_CONFIG = "${jsonencode(local.kubespray_config)}"
    }
  }

  depends_on = [
    hcloud_server.kube_control_plane,
    hcloud_server.kube_node
  ]
}
