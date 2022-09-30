
# Patch for Argocd Repo Server with Vault Sidecar Containers
data "template_file" "argocd_repo_server_tmpl" {
  template = file("${path.root}/templates/argocd-repo-server.yml.tpl")

  vars = {
    argocd_version = var.kubespray_argocd_config["argocd_version"]
  }
}

resource "local_file" "argocd_repo_server_tmpl" {
  depends_on = [data.template_file.argocd_repo_server_tmpl]

  content  = data.template_file.argocd_repo_server_tmpl.rendered
  filename = "/kubespray/roles/kubernetes-apps/argocd/bootstrap/argocd-repo-server.yml"
}

# ConfigMap for Argocd Repo Server with Vault Sidecar Containers
data "template_file" "argocd_cmp_plugin" {
  template = file("${path.root}/templates/argocd-cmp-plugin.yml.tpl.j2")
}

resource "local_file" "argocd_cmp_plugin" {
  depends_on = [data.template_file.argocd_cmp_plugin]

  content  = data.template_file.argocd_cmp_plugin.rendered
  filename = "/kubespray/roles/kubernetes-apps/argocd/bootstrap/argocd-cmp-plugin.yml"
}

#  Argocd Repo Server Vault Configuration
data "template_file" "argocd_vault_configuration_tmpl" {
  template = file("${path.root}/templates/argocd-vault-configuration.yml.tpl")

  vars = {
    argocd_namespace     = var.kubespray_argocd_config["argocd_namespace"]
    argocd_vault_token   = var.argocd_vault_token
    argocd_vault_address = var.argocd_vault_address
  }
}

resource "local_file" "argocd_vault_configuration_tmpl" {
  depends_on = [data.template_file.argocd_vault_configuration_tmpl]

  content  = data.template_file.argocd_vault_configuration_tmpl.rendered
  filename = "/kubespray/roles/kubernetes-apps/argocd/bootstrap/argocd-vault-configuration.yml"
}

# Boostrapping ArgoCD apps with app of apps pattern
data "template_file" "argocd_bootstrap_app_tmpl" {
  template = file("${path.root}/templates/argocd-bootstrap-app.yml.tpl")

  vars = {
    argocd_bootstrap_repo_url = var.argocd_bootstrap_app_repo_url
    argocd_namespace          = var.kubespray_argocd_config["argocd_namespace"]
  }
}

resource "local_file" "argocd_bootstrap_task" {
  depends_on = [data.template_file.argocd_bootstrap_app_tmpl]

  content  = data.template_file.argocd_bootstrap_app_tmpl.rendered
  filename = "/kubespray/roles/kubernetes-apps/argocd/bootstrap/argocd-bootstrap-app.yml"
}
