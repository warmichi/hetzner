output "env-dynamic-url" {
  value = "https://${hcloud_server.rancher[count.1].ipv4_address}"
}
