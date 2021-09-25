[all:vars]
ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

[rancher]
${k8s_control_plane_hosts_def}