resource "null_resource" "run_ansible" {
  triggers = {
    hcloud_server_ids = join(",", hcloud_server.kube_control_plane.*.id)
  }

  provisioner "local-exec" {
    # command = "chmod 600 ${var.HCLOUD_SSH_ROOT_PRIVATE_KEY} && sleep 60 && ansible-playbook -i ${path.root}/inventory ${path.root}/ansible/playbook.yaml"
    command = "chmod 600 ${var.HCLOUD_SSH_ROOT_PRIVATE_KEY} && sleep 60 && ansible-playbook -i ${path.root}/inventory cluster.yaml"
    environment = {
      ANSIBLE_PRIVATE_KEY_FILE  = "${var.HCLOUD_SSH_ROOT_PRIVATE_KEY}"
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
  depends_on = [
    hetznerdns_record.kube_control_plane,
    hcloud_server.kube_control_plane,
  ]
}
