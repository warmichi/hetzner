apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apps
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://gitlab.com:infrastructure64/argocd-bootstrap.git
    targetRevision: HEAD
    path: .
  destination:
    server: https://kubernetes.default.svc 
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true