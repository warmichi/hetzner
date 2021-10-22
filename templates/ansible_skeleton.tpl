---
all:
${ansible_all_kube_nodes_def}

kube_control_plane:
  hosts:
${ansible_kube_control_plane_def}:

kube_node:
  hosts:
${ansible_kube_node_def}:

k8s_cluster:
  children:
    kube_control_plane:
  vars:
    ansible_user: ${ansible_user}
