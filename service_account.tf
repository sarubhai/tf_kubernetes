# service_account.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service_account & cluster role binding resources in Kubernetes cluster
# UseCase: Vault Auth Service Account

resource "kubernetes_service_account" "vault_auth_sa" {
  metadata {
    namespace = "default"
    name      = "vault-auth-sa"

    labels = {
      name       = "vault-auth-sa"
      instance   = "vault-auth-sa"
      version    = "v1"
      component  = "vault-auth"
      part-of    = "vault"
      managed-by = "terraform"
      created-by = var.owner
    }
  }
}


resource "kubernetes_cluster_role_binding" "vault_auth_sa_role_binding" {
  metadata {
    name = "vault-role-tokenreview-binding"

    labels = {
      name       = "vault-role-tokenreview-binding"
      instance   = "vault-role-tokenreview-binding"
      version    = "v1"
      component  = "vault-role-tokenreview-binding"
      part-of    = "vault"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault_auth_sa.metadata.0.name
    namespace = "default"
  }
}
