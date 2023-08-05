terraform {
  backend "vault" {
    address = "https://vault.uwannah.com:8200"
    path    = "secret/prod/terraform/state"
    token   = "${var.VAULT_TOKEN}"
  }
}