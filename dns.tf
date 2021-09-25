data "hetznerdns_zone" "dns_zone" {
  name = local.domain
}

resource "hetznerdns_record" "k8s_control_plane" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = local.k8s_hostname
  value   = hcloud_server.k8s_control_plane[0].ipv4_address
  type    = "A"
  ttl     = 60
}

resource "hetznerdns_record" "k8s_control_plane_cname" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = local.k8s_cluster_name
  value   = hetznerdns_record.k8s_control_plane.name
  type    = "CNAME"
  ttl     = 60
}