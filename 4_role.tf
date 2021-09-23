# role.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes role resources in Kubernetes cluster
# A Role contains rules that represent a set of permissions applicable to a single namespace

# Generic
resource "kubernetes_role" "generic_rw_role" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-rw-role"

    labels = {
      name    = "generic-rw-role"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "roles"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  rule {
    resources  = ["pods"]
    verbs      = ["create", "update", "patch", "get", "list", "watch", "delete"]
    api_groups = [""]
    # resource_names = []
  }

  # lifecycle {
  #   ignore_changes = [rule.0.resource_names]
  # }
}

# Validation
# kubectl get roles -n generic-ns
# kubectl describe role generic-rw-role -n generic-ns
