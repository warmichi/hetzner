apiVersion: v1
stringData:
  VAULT_ADDR: ${argocd_vault_address}
  VAULT_TOKEN: ${argocd_vault_token}
  AVP_TYPE: vault
  AVP_AUTH_TYPE: token
kind: Secret
metadata:
  name: vault-configuration
  namespace: ${argocd_namespace}
type: Opaque