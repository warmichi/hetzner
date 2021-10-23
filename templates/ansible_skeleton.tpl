[all]
${connection_strings_control_plane}
${connection_strings_node}

[kube_control_plane]
${list_control_plane}

[etcd]
${list_control_plane}

[kube_node]
${list_node}

[k8s_cluster:children]
kube_node
kube_control_plane
