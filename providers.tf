provider "hcloud" {
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = "https://rancher.${local.domain}"
  bootstrap = true
}

provider "rancher2" {
  api_url   = "https://rancher.${local.domain}"
  token_key = rancher2_bootstrap.admin.token
}

provider "rke" {
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_cluster_yaml.filename
  }
}
