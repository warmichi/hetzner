output "env-dynamic-url" {
  value = "https://${hcloud_server.rancher.ipv4_address}"
}
