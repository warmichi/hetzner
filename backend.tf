# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "warmichi"

#     workspaces {
#       name = "hetzner"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket     = "kube-1-terraform-state-prod"
    key        = "terraform.tfstate"
    endpoint   = "s3.uwannah.com" 
  }
}

