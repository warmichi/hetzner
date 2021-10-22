output "env-dynamic-url" {
  value = local.kube_cluster_name
}

output "map" {
  value = var.ansible_kube_control_plane
}