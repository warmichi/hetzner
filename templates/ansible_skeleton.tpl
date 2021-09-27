[all]
${kube_control_plane_hosts_def}

[kube_control_plane]

[k8s_cluster:children]
${kube_control_plane_hosts_def}