data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    HCLOUD_SSH_WARMICHI_PUBLIC_KEY  = var.hcloud_ssh_warmichi_public_key
    HCLOUD_SSH_WARMICHI_PRIVATE_KEY = var.hcloud_ssh_warmichi_private_key
  }
}