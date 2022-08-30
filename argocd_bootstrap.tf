data "template_file" "argocd_bootstrap_tmpl" {
  template = file("${path.root}/templates/argocd_bootstrap.tpl")

  vars = { argocd_bootstrap_repo_url = var.argocd_bootstrap_repo_url }
}

resource "local_file" "argocd_bootstrap_task" {
  depends_on = [data.template_file.argocd_bootstrap_tmpl]

  content  = data.template_file.argocd_bootstrap_tmpl.rendered
  filename = "${path.root}/kubespray/roles/kubernetes-apps/argocd/tasks/argocd_bootstrap.yml"
}
