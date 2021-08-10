# install rancher
# resource "helm_release" "rancher" {
#   name = "rancher"
#   #  repository = "https://releases.rancher.com/server-charts/latest"
#   chart     = "rancher-latest/rancher"
#   version   = var.rancher_version
#   namespace = "cattle-system"
#   set {
#     name  = "hostname"
#     value = "${local.rancher_hostname}.${local.domain}"
#   }
# }

resource "null_resource" "wait_for_rancher" {
  provisioner "local-exec" {
    command = <<EOF
while [ "$${resp}" != "pong" ]; do
    resp=$(curl -sSk -m 2 "https://$${RANCHER_HOSTNAME}:8443/ping")
    echo "Rancher Response: $${resp}"
    if [ "$${resp}" != "pong" ]; then
      sleep 10
    fi
done
EOF


    environment = {
      RANCHER_HOSTNAME = "${local.rancher_hostname}.${local.domain}"
      # TF_LINK          = helm_release.rancher.name
    }
  }
  depends_on = [
    hetznerdns_record.rancher,
  ]
}

resource "rancher2_bootstrap" "admin" {
  # provider = rancher2.bootstrap

  depends_on = [null_resource.wait_for_rancher]
  password   = "test"
}
