provider "hcloud" {
}

provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://rancher.${local.domain}"
  bootstrap = true
}

provider "rancher2" {
  alias = "admin"

  api_url   = "https://rancher.${local.domain}"
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}

provider "rke" {
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_cluster_yaml.filename
  }
}
