# service_account.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service account resources in Kubernetes cluster
# A ServiceAccount provides an identity for processes that run in a Pod.

resource "kubernetes_service_account" "generic_sa" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "genric-sa"

    labels = {
      name    = "genric-sa"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "sa"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }
}

# Validation
# kubectl get serviceaccounts -n generic-ns
# kubectl describe serviceaccount genric-sa -n generic-ns
