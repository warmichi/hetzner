data "hetznerdns_zone" "dns_zone" {
  name = local.domain
}

resource "hetznerdns_record" "kube_control_plane" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = local.kube_control_plane_hostname
  value   = hcloud_server.kube_control_plane.*.ipv4_address
  type    = "A"
  ttl     = 60
}

# resource "hetznerdns_record" "kube_control_plane_cname" {
#   zone_id = data.hetznerdns_zone.dns_zone.id
#   name    = local.kube_cluster_name
#   value   = hetznerdns_record.kube_control_plane.name
#   type    = "CNAME"
#   ttl     = 60
# }