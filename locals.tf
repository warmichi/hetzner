locals {
  kubespray_config = merge(
    var.kubespray_kube_config,
    { network_id = var.kube_cluster_name },
    var.kubespray_argocd_config,
    var.kubespray_ingress_config,
    { external_hcloud_cloud = merge(var.kubespray_cloud_provider_config["external_hcloud_cloud"], {hcloud_api_token = var.hcloud_token}) } # inject hcloud token variable
  )
}