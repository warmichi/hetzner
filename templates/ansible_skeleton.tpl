[all:vars]
ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

[kube_control_plane]
${kube_control_plane_hosts_def}

[k8s_cluster:children]
${kube_control_plane_hosts_def}