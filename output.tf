output "env-dynamic-url" {
  value = local.kube_cluster_name
}

output "test" {
  value = [for hcloud_server in hcloud_server.kube_control_plane : hcloud_server.name => hcloud]
}