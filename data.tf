data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    rancher_token_key = var.RANCHER_TOKEN_KEY
  }
}