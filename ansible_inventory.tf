# data "template_file" "ansible_all_kube_nodes" {
#   count      = local.kube_control_plane_count
#   template   = file("${path.root}/templates/ansible_hosts.tpl")
#   depends_on = [hcloud_server.kube_control_plane]

#   vars = {
#     node_name    = join("", element(hcloud_server.kube_control_plane.*.name, count.index), element(hcloud_server.kube_node.*.name, count.index))
#     ansible_user = local.hetzner_ssh_user
#     ip           = element(hcloud_server.kube_control_plane.*.ipv4_address, count.index)
#   }
# }

data "template_file" "ansible_skeleton" {
  template = file("${path.root}/templates/ansible_skeleton.tpl")

  vars = {
    # ansible_all_kube_nodes_def     = join("", data.template_file.ansible_all_kube_nodes.*.rendered)
    ansible_all_kube_nodes_def     = zipmap(hcloud_server.kube_control_plane.*.name, hcloud_server.kube_control_plane.*.ipv4_address)
    ansible_kube_control_plane_def = join("", hcloud_server.kube_control_plane.*.name)
    ansible_kube_node_def          = join("", hcloud_server.kube_node.*.name)
    ansible_user                   = local.hetzner_ssh_user
    # kube_all_hosts               = join("", hcloud_server.kube_control_plane.*.name, hcloud_server.kube_worker.*.name)
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_skeleton]

  content  = data.template_file.ansible_skeleton.rendered
  filename = "${path.root}/inventory"
}
