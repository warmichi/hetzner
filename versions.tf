terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.28.1"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "1.1.1"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.16.0"
    }
  }
}