data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    RANCHER_TOKEN_KEY = var.RANCHER_TOKEN_KEY
    RANCHER_VERSION   = local.rancher_version
  }
}