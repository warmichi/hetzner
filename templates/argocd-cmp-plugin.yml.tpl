apiVersion: v1
kind: ConfigMap
metadata:
  name: cmp-plugin
  namespace: argocd
data:
  avp-kustomize.yaml: |
    ---
    apiVersion: argoproj.io/v1alpha1
    kind: ConfigManagementPlugin
    metadata:
      name: argocd-vault-plugin-kustomize
    spec:
      allowConcurrency: true
      # Note: this command is run _before_ anything is done, therefore the logic is to check
      # if this looks like a Kustomize bundle
      discover:
        find:
          command:
            - find
            - "."
            - -name
            - kustomization.yml
      generate:
        command:
          - sh
          - "-c"
          - "kustomize build . | argocd-vault-plugin generate -s vault-configuration -"
      lockRepo: false
  avp-helm.yaml: |
    ---
    apiVersion: argoproj.io/v1alpha1
    kind: ConfigManagementPlugin
    metadata:
      name: argocd-vault-plugin-helm
    spec:
      allowConcurrency: true
      # Note: this command is run _before_ any Helm templating is done, therefore the logic is to check
      # if this looks like a Helm chart
      discover:
        find:
          command:
            - sh
            - "-c"
            - "find . -name 'Chart.yml' && find . -name 'values.yml'"
      generate:
        command:
          - sh
          - "-c"
          - |
            helm template $ARGOCD_APP_NAME -n $ARGOCD_APP_NAMESPACE $${ARGOCD_ENV_HELM_ARGS} . |
            argocd-vault-plugin generate -s vault-configuration -
      lockRepo: false
  avp.yaml: |
    apiVersion: argoproj.io/v1alpha1
    kind: ConfigManagementPlugin
    metadata:
      name: argocd-vault-plugin
    spec:
      allowConcurrency: true
      discover:
        find:
          command:
            - sh
            - "-c"
            - "find . -name '*.yml' | xargs -I {} grep \"<path\\|avp\\.kubernetes\\.io\" {} | grep ."
      generate:
        command:
          - argocd-vault-plugin
          - generate
          - "-s"
          - "vault-configuration"
          - "."
      lockRepo: false
---