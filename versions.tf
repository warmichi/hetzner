terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.28.1"
    }
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.16.0"
    }
    rke = {
      source = "rancher/rke"
      version = "1.2.3"
    }
    helm = {
      version ="2.2.0"
    }
  }
}