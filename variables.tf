variable "kube_cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "kube"
}

variable "kubespray_kube_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    kube_version            = "v1.21.0"
    cloud_provider          = "external"
    external_cloud_provider = "hcloud"
  }
}

variable "kubespray_ingress_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    ingress_nginx_enabled = true
    ingress_nginx_class   = "nginx"
  }

}

variable "kubespray_cloud_provider_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    network_id = ""
    external_hcloud_cloud = {
      token_secret_name    = "hcloud"
      hcloud_api_token     = ""
      with_networks        = true
      controller_image_tag = "latest"
      service_account_name = "cloud-controller-manager"
    }
  }
}

variable "kubespray_argocd_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    argocd_enabled   = true
    argocd_version   = "v2.4.7"
    argocd_namespace = "argocd"
  }
}

# variable "kube_cluster_variables" {
#   description = "Additional Playbook Variables"
#   default = {
#     kube_version            = "v1.21.0"
#     cloud_provider          = "external"
#     external_cloud_provider = "hcloud"

#     external_hcloud_cloud = {
#       token_secret_name    = "hcloud"
#       with_networks        = true
#       controller_image_tag = "latest"
#       service_account_name = "cloud-controller-manager"
#     }

#     ingress_nginx_enabled = true
#     ingress_nginx_class   = "nginx"

#     argocd_enabled   = true
#     argocd_version   = "v2.4.7"
#     argocd_namespace = "argocd"
#   }

#   type = object({
#     kube_version = string

#     cloud_provider          = string
#     external_cloud_provider = string

#     external_hcloud_cloud = object({
#       token_secret_name    = string
#       with_networks        = bool
#       controller_image_tag = string
#       service_account_name = string
#     })

#     ingress_nginx_enabled = bool
#     ingress_nginx_class   = string

#     argocd_enabled   = bool
#     argocd_version   = string
#     argocd_namespace = string
#   })
# }

# variable "kube_version" {
#   type        = string
#   description = "Kubernetes Version"
#   default     = "v1.20.1"
# }

variable "kube_control_plane_count" {
  type        = number
  description = "Number of control-plane nodes"
  default     = 3
}

variable "kube_node_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

variable "hetzner_control_plane_type" {
  type        = string
  description = "Hetzner server type for control-plane nodes"
  default     = "cpx11"
}

variable "hetzner_node_server_type" {
  type        = string
  description = "Hetzner server type for worker nodes"
  default     = "cx21"
}

variable "hetzner_lb_type" {
  type        = string
  description = "Hetzner Loadbalander type"
  default     = "lb11"
}

variable "hetzner_image" {
  type        = string
  description = "Hetzner OS Image"
  default     = "ubuntu-20.04"
}

variable "hetzner_datacenter" {
  type        = string
  description = "Hetzner Datacenter"
  default     = "nbg1"
}

variable "hetzner_ssh_user" {
  type        = string
  description = "Hetzner ssh-user"
  default     = "root"
}

variable "network_zone" {
  type        = string
  description = "Hetzner Network-Zone"
  default     = "eu-central"
}

variable "ip_range" {
  type        = string
  description = "ip_range for Hetzner Network-Zone"
  default     = "192.168.0.0/16"
}

variable "domain" {
  type        = string
  description = "Domain used for Server Hostnames"
  default     = "uwannah.com"
}

# Enviroment variables coming from vault
variable "hcloud_token" {
  default = ""
}

variable "hcloud_ssh_root_public_key" {
  description = "Public root ssh-key for Hetzner"
  type        = string
}

variable "hcloud_ssh_root_private_key" {
  description = "Private root ssh-key for Hetzner"
  type        = string
}

variable "hcloud_ssh_warmichi_public_key" {
  description = "Private root ssh-key for Hetzner"
  type        = string
}

