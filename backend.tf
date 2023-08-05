terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "warmichi"

    workspaces {
      name = "hetzner"
    }
  }
}