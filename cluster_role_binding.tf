# cluster_role_binding.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes cluster role binding resources in Kubernetes cluster
# UseCase: Vault Auth Service Account for Kubernetes Auth Method
# A ClusterRoleBinding may be used to grant permission at the cluster level and in all namespaces

# Generic
resource "kubernetes_cluster_role_binding" "generic_sa_cluster_role_binding" {
  metadata {
    name = "generic-sa-cluster-role-binding"

    labels = {
      name    = "generic-sa-cluster-role-binding"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "clusterrolebindings"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.generic_ro_cluster_role.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.generic_sa.metadata.0.name
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
  }
}

# VAULT
resource "kubernetes_cluster_role_binding" "vault_auth_sa_role_binding" {
  metadata {
    name = "vault-role-tokenreview-binding"

    labels = {
      name    = "vault-role-tokenreview-binding"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "clusterrolebindings"
      part-of    = "vault"
      managed-by = "terraform"
      created-by = var.owner
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

# Validation
# kubectl get clusterrolebindings
# kubectl describe clusterrolebinding generic-sa-cluster-role-binding
