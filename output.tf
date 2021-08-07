output "env-dynamic-url" {
  value = "https://${hcloud_server.rancher-1.ipv4_address}"
}
