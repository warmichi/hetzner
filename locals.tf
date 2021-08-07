resource "random_id" "id" {
  byte_length = 8
}

locals {
  rancher_hostname   = "${var.cluster_name}-${random_id.id.hex}"
  rancher_node_count = 1
  domain             = "uwannah.com"
}