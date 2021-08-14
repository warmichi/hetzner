provider "hcloud" {
}

provider "hetznerdns" {
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = local.rancher_api_url
  bootstrap = true
  insecure  = true
}

provider "rancher2" {
  alias     = "admin"
  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}
