output "env-dynamic-url" {
  value = local.kube_cluster_name
}

output "test" {
  value = hcloud_server.kube_control_plane
}