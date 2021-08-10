output "env-dynamic-url" {
  value = "https://${hcloud_server.rancher[0].ipv4_address}"
}
