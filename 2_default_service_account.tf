# default_service_account.tf
# Owner: Saurav Mitra
# Description: This terraform config will adopt the kubernetes default service account resources in Kubernetes cluster
# Kubernetes creates a "default" service account in each namespace. This is the service account that will be assigned by default to pods in the namespace.
# The service account is created by a Kubernetes controller and Terraform "adopts" it into management.

/*
resource "kubernetes_default_service_account" "default_sa" {
  metadata {
    namespace   = kubernetes_namespace.generic_ns.metadata.0.name
    name        = "default"
    labels      = {}
    annotations = {}
  }

  automount_service_account_token = false
}
*/

# Validation
# terraform import kubernetes_default_service_account.default_sa generic-ns/default
# terraform state rm kubernetes_default_service_account.default_sa
# kubectl get serviceaccounts -n generic-ns
# kubectl describe serviceaccount default -n generic-ns
