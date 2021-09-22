# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes namespace resources in Kubernetes cluster

# Generic
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

# App
resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "${var.prefix}-ns"

    labels = {
      name    = "${var.prefix}-ns"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "ns"
      part-of    = var.prefix
      managed-by = "terraform"
      created-by = var.owner
    }
  }
}


# Validation
# kubectl get namespaces
# kubectl describe namespaces generic-ns
# kubectl get all -n generic-ns
# kubectl get pods -n generic-ns -o wide
