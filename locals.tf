resource "random_id" "id" {
  byte_length = 8
}

locals {
  rancher_hostname   = "${var.cluster_name}-${random_id.id.hex}"
  rancher_node_count = 1
  rancher_api_url    = "https://${local.rancher_hostname}.${local.domain}:8443"
  domain             = "uwannah.com"
}