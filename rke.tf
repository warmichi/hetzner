############################
### RKE Cluster
###########################
# resource "rke_cluster" "rancher_server" {
#   depends_on = [null_resource.wait_for_docker]

#   dynamic "nodes" {
#     for_each = hcloud_server.rancher
#     content {
#       address          = nodes.value.ipv4_address
#       internal_address = nodes.value.ipv4_address
#       user             = "root"
#       role             = ["controlplane", "etcd", "worker"]
#       ssh_key          = file(var.HCLOUD_SSH_RANCHER_PRIVATE_KEY)
#     }
#   }

#   cluster_name = var.cluster_name
#   # addons       = file("${path.module}/files/addons.yaml")
#   kubernetes_version = var.kubernetes_version

#   services_etcd {
#     # for etcd snapshots
#     backup_config {
#       interval_hours = 12
#       retention      = 6
#     }
#   }
# }

# resource "local_file" "kube_cluster_yaml" {
#   filename = "${path.root}/outputs/kube_config_cluster.yml"
#   content  = rke_cluster.rancher_server.kube_config_yaml
# }
