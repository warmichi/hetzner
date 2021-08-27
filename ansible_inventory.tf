data "template_file" "ansible_web_hosts" {
  count      = local.rancher_node_count
  template   = file("${path.root}/templates/ansible_hosts.tpl")
  depends_on = [hcloud_server.rancher]

  vars = {
    node_name    = element(hcloud_server.rancher.*.name, count.index)
    ansible_user = local.hetzener_ssh_user
    ip           = element(hcloud_server.rancher.*.ipv4_address, count.index)
  }
}

data "template_file" "ansible_skeleton" {
  template = file("${path.root}/templates/ansible_skeleton.tpl")

  vars = {
    rancher_hosts_def = join("", data.template_file.ansible_web_hosts.*.rendered)
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_skeleton]

  content  = data.template_file.ansible_skeleton.rendered
  filename = "${path.root}/inventory"
}
