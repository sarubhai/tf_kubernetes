# vault_auth_kubernetes.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service account & cluster role binding resources in Kubernetes cluster
# UseCase: Vault Auth Service Account for Kubernetes Auth Method

# Vault Service Account
resource "kubernetes_service_account" "vault_auth_sa" {
  metadata {
    namespace = "default"
    name      = "vault-auth-sa"

    labels = {
      name = "vault-auth-sa"
    }

    annotations = {
      component  = "sa"
      part-of    = "vault-auth"
      managed-by = "terraform"
    }
  }
}

# Vault Cluster Role Binding
resource "kubernetes_cluster_role_binding" "vault_auth_sa_role_binding" {
  metadata {
    name = "vault-role-tokenreview-binding"

    labels = {
      name = "vault-role-tokenreview-binding"
    }

    annotations = {
      component  = "clusterrolebindings"
      part-of    = "vault-auth"
      managed-by = "terraform"
    }
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault_auth_sa.metadata.0.name
    namespace = "default"
  }
}
