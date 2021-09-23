# role_binding.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes role binding resources in Kubernetes cluster
# A RoleBinding may be used to grant permission at the namespace level

# Generic
resource "kubernetes_role_binding" "generic_sa_role_binding" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-sa-role-binding"

    labels = {
      name    = "generic-sa-role-binding"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "rolebindings"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_role.generic_rw_role.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.generic_sa.metadata.0.name
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
  }
}

# Validation
# kubectl get rolebindings -n generic-ns
# kubectl describe rolebinding generic-sa-role-binding -n generic-ns
