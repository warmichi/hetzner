data "template_file" "ansible_kube_hosts" {
  count      = local.kube_control_plane_count
  template   = file("${path.root}/templates/ansible_hosts.tpl")
  depends_on = [hcloud_server.kube_control_plane]

  vars = {
    node_name    = element(hcloud_server.kube_control_plane.*.name, count.index)
    ansible_user = local.hetzener_ssh_user
    ip           = element(hcloud_server.kube_control_plane.*.ipv4_address, count.index)
  }
}

data "template_file" "ansible_skeleton" {
  template = file("${path.root}/templates/ansible_skeleton.tpl")

  vars = {
    kube_control_plane_hosts_def = join("", data.template_file.ansible_kube_hosts.*.rendered)
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_skeleton]

  content  = data.template_file.ansible_skeleton.rendered
  filename = "${path.root}/inventory"
}
