kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
 namespace: ${argocd_namespace}
 name: role-argocd-repo-server
rules:
- apiGroups: [""]
  resources: ["secrets", "configmaps"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]