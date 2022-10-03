terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.35.2"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }
}