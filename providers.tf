provider "hcloud" {
}

provider "hetznerdns" {
}

provider "rancher2" {
  api_url   = "https://${local.rancher_hostname}.${local.domain}:8443"

  bootstrap = true
  insecure  = true
}

# provider "rancher2" {
#   api_url   = rancher2_bootstrap.admin.url
#   token_key = rancher2_bootstrap.admin.token
#   insecure  = true
# }

# provider "helm" {
#   kubernetes {
#     config_path = local_file.kube_cluster_yaml.filename
#   }
# }
