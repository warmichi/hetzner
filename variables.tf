variable "kube_cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "kube"
}

variable "kubespray_kube_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    kube_version            = "v1.24.6"
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
    cert_manager_enabled  = true
  }

}

variable "kubespray_cloud_provider_config" {
  description = "Additional Playbook Variables"
  type        = map(any)
  default = {
    external_hcloud_cloud = {
      token_secret_name    = "hcloud"
      hcloud_api_token     = ""
      with_networks        = true
      controller_image_tag = "latest"
      service_account_name = "cloud-controller-manager"
    }
  }
}

variable "argocd_bootstrap_app_repo_url" {
  default = "https://gitlab.com/infrastructure64/argo-cd-apps.git"
}

variable "argocd_vault_token" {
  default = ""
}

variable "argocd_vault_address" {
  default = "https://vault.uwannah.com:8200/"
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

variable "kube_control_plane_count" {
  type        = number
  description = "Number of control-plane nodes"
  default     = 1
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

#Enviroment variables coming from vault
variable "hcloud_token" {
  type = string
}

variable "HCLOUD_SSH_ROOT_PUBLIC_KEY" {
  description = "Public root ssh-key for Hetzner"
  type        = string
}

variable "HCLOUD_SSH_ROOT_PRIVATE_KEY" {
  description = "Private root ssh-key for Hetzner"
  type        = string
}

variable "HCLOUD_SSH_WARMICHI_PUBLIC_KEY" {
  description = "Private root ssh-key for Hetzner"
  type        = string
}