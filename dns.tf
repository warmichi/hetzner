data "hetznerdns_zone" "dns_zone" {
    name = local.domain
}

data "hcloud_server" "web" {
    name = local.rancher_hostname
}

resource "hetznerdns_record" "web" {
    zone_id = data.hetznerdns_zone.dns_zone.id
    name = "www"
    value = hcloud_server.rancher[0].ipv4_address
    type = "A"
    ttl= 60
}
