# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "warmichi"

#     workspaces {
#       name = "hetzner"
#     }
#   }
# }

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket   = "kube-1-terraform-state-prod"
    key      = "terraform.tfstate"
    endpoint = "s3.uwannah.com" 
    access_key = var.ACCESS_KEY
    secret_key = var.SECRET_ACCESS_KEY
  }
}
