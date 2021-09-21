data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    HCLOUD_SSH_WARMICHI_PUBLIC_KEY  = var.HCLOUD_SSH_WARMICHI_PUBLIC_KEY
    HCLOUD_SSH_WARMICHI_PRIVATE_KEY = var.HCLOUD_SSH_WARMICHI_PRIVATE_KEY
  }
}