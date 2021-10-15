data "hetznerdns_zone" "dns_zone" {
  name = local.domain
}

resource "hetznerdns_record" "kube_control_plane" {
  for_each = {for hcloud_server in hcloud_server.kube_control_plane : hcloud_server.name => hcloud}
  zone_id  = data.hetznerdns_zone.dns_zone.id
  name     = each.value.name
  value    = each.value.ipv4_address
  type     = "A"
  ttl      = 60
}

# resource "hetznerdns_record" "kube_control_plane_cname" {
#   zone_id = data.hetznerdns_zone.dns_zone.id
#   name    = local.kube_cluster_name
#   value   = hetznerdns_record.kube_control_plane.name
#   type    = "CNAME"
#   ttl     = 60
# }

# for_each = join("", hcloud_server.kube_control_plane)  