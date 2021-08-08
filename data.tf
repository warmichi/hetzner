# resource "helm_release" "rancher_stable" {
#   name  = "rancher-stable"
#   chart = "rancher/rancher2"
# }

data "template_file" "cloud_init" {
  template = file("${path.module}/files/cloud-config.yaml")
  vars = {
    rancher_api_url = "${local.rancher_api_url}"
  }
}

data "rancher2_user" "admin" {
  username   = "admin"
  depends_on = [rancher2_bootstrap.admin]
}
