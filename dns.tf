data "hetznerdns_zone" "dns_zone" {
  name = local.domain
}

resource "hetznerdns_record" "rancher" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = local.rancher_hostname
  value   = hcloud_server.rancher.*.ipv4_address
  type    = "A"
  ttl     = 60
}

resource "hetznerdns_record" "rancher_cname" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = local.rancher_cluster_name
  value   = hetznerdns_record.rancher.name
  type    = "CNAME"
  ttl     = 60
}