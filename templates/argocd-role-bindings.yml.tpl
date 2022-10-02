kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
 name: role-argocd-repo-server
 namespace: argocd
subjects:
- kind: ServiceAccount
  name: argocd-repo-server
  namespace: argocd
roleRef:
 kind: Role
 name: role-argocd-repo-server
 apiGroup: rbac.authorization.k8s.io