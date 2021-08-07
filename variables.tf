variable "cluster_name" {
  description = "prefix for cloud resources"
  default     = "rancher-mgmt"
}
variable "HCLOUD_SSH_RANCHER_PUBLIC_KEY" {
  description = "SSH public key file"
}

# variable "HCLOUD_SSH_RANCHER_PRIVATE_KEY_FILE" {
#   description = "SSH private key file used to access instances"
# }

# variable "ssh_port" {
#   description = "SSH port to be used to provision instances"
#   default     = 22
# }

# variable "ssh_username" {
#   description = "SSH user, used only in output"
#   default     = "root"
# }

# variable "ssh_agent_socket" {
#   description = "SSH Agent socket, default to grab from $SSH_AUTH_SOCK"
#   default     = "env:SSH_AUTH_SOCK"
# }

# Provider specific settings

variable "rancher-mgmt" {
  default = "cx21"
}

variable "datacenter" {
  default = "nbg1"
}

variable "image" {
  default = "ubuntu-20.04"
}

variable "ip_range" {
  default     = "192.168.0.0/16"
  description = "ip range to use for private network"
}

variable "network_zone" {
  default     = "eu-central"
  description = "network zone to use for private network"
}