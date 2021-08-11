# resource "helm_release" "rancher_stable" {
#   name  = "rancher-stable"
#   chart = "rancher/rancher2"
# }

data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    RANCHER_TOKEN_KEY = local.RANCHER_TOKEN_KEY
  }
}

data "rancher2_user" "admin" {
  username   = "admin"
  depends_on = [rancher2_bootstrap.admin]
}
