data "template_file" "ansible_skeleton" {
  template = file("${path.root}/templates/ansible-skeleton.tpl")

  vars = {
    connection_strings_control_plane = join("\n", formatlist("%s ansible_host=%s", hcloud_server.kube_control_plane.*.name, hcloud_server.kube_control_plane.*.ipv4_address))
    connection_strings_node          = join("\n", formatlist("%s ansible_host=%s", hcloud_server.kube_node.*.name, hcloud_server.kube_node.*.ipv4_address))
    list_control_plane               = join("\n", hcloud_server.kube_control_plane.*.name)
    list_node                        = join("\n", hcloud_server.kube_node.*.name)
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_skeleton]

  content  = data.template_file.ansible_skeleton.rendered
  filename = "${path.root}/inventory"
}
