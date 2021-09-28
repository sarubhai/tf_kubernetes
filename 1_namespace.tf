# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes namespace resources in Kubernetes cluster
# Kubernetes supports multiple virtual clusters backed by the same physical cluster, called namespaces

resource "kubernetes_namespace" "generic_ns" {
  metadata {
    name = "generic-ns"

    labels = {
      name    = "generic-ns"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "ns"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }
}

# Validation
# kubectl get namespaces
# kubectl describe namespaces generic-ns
# kubectl config set-context $(kubectl config current-context) --namespace=generic-ns
# kubectl get all -n generic-ns
# kubectl get pods -n generic-ns -o wide
