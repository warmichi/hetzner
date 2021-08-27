data "template_file" "ansible_web_hosts" {
  template   = file("${path.root}/templates/ansible_hosts.tpl")
  depends_on = [hcloud_server.rancher]

  vars = {
    node_name    = hcloud_server.rancher.*.name
    ansible_user = local.hetzener_ssh_user
    ip           = element(hcloud_server.rancher.*.ipv4_address)
  }
}

data "template_file" "ansible_skeleton" {
  template = file("${path.root}/templates/ansible_skeleton.tpl")

  vars = {
    rancher_hosts_def = join("", data.template_file.ansible_web_hosts.*.rendered, count.index)
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [data.template_file.ansible_skeleton]

  content  = data.template_file.ansible_skeleton.rendered
  filename = "${path.root}/inventory"
}
