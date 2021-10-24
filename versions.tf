terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.31.1"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "1.1.1"
    }
  }
}