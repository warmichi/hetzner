[all]
${kube_all_hosts}

[kube_control_plane]
${kube_control_plane_hosts_def}

[k8s_cluster:children]
${kube_control_plane_hosts_def}