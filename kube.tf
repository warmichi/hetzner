# resource "null_resource" "run_ansible" {
#   triggers = {
#     hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id)
#   }

#   provisioner "local-exec" {
#     # command = "chmod 600 ${var.HCLOUD_SSH_ROOT_PRIVATE_KEY} && sleep 60 && ansible-playbook -i ${path.root}/inventory ${path.root}/ansible/playbook.yaml"
#     command = "chmod 600 ${var.hcloud_ssh_root_private_key} && sleep 60 && ansible-playbook -i ${path.root}/inventory /kubespray/cluster.yaml"
#     environment = {
#       ANSIBLE_PRIVATE_KEY_FILE  = "${var.hcloud_ssh_root_private_key}"
#       ANSIBLE_HOST_KEY_CHECKING = "False"
#     }
#   }
#   depends_on = [
#     hetznerdns_record.kube_control_plane,
#     hcloud_server.kube_control_plane,
#   ]
# }
