output "env-dynamic-url" {
  value = local.kube_cluster_name
}

output "yo" {
  value = data.template_file.ansible_skeleton.rendered
}
output "test" {
  value = data.template_file.ansible_kube_hosts.*.rendered
}