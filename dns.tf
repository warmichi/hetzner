data "hetznerdns_zone" "dns_zone" {
  name = var.domain
}

resource "hetznerdns_record" "kube_control_plane" {
  count   = var.kube_control_plane_count
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = hcloud_server.kube_control_plane[count.index].name
  value   = hcloud_server.kube_control_plane[count.index].ipv4_address
  type    = "A"
  ttl     = 60
}

resource "hetznerdns_record" "kube_node" {
  count   = var.kube_node_count
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = hcloud_server.kube_node[count.index].name
  value   = hcloud_server.kube_node[count.index].ipv4_address
  type    = "A"
  ttl     = 60
}