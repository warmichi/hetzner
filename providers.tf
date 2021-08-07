provider "hcloud" {
  token = var.hcloud_token
}

provider "rke" {
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_cluster_yaml.filename
  }
}

provider "rancher2" {
  version = "1.16.0"
  alias     = "bootstrap"
  api_url   = "https://${local.name}.${local.domain}"
  bootstrap = true
}

provider "rancher2" {
  version = "1.16.0"
  api_url   = "https://${local.name}.${local.domain}"
  token_key = rancher2_bootstrap.admin.token
}
