apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apps
  namespace: ${argocd_namespace}
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: ${argocd_bootstrap_repo_url}
    targetRevision: HEAD
    path: .
  destination:
    server: https://kubernetes.default.svc 
    namespace: ${argocd_namespace}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true