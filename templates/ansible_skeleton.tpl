---

kube_control_plane:
  hosts:
${kube_control_plane_hosts_def}

k8s_cluster:
  children:
    kube_control_plane:
  vars:
    ansible_user: ${ansible_user}
