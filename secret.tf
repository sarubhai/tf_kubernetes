# secret.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes secret resources in Kubernetes cluster
# Secrets store sensitive information either as fine-grained information like individual properties or coarse-grained entries like entire files or JSON blobs. 
# The resource provides mechanisms to inject containers with sensitive information, such as passwords, while keeping containers agnostic of Kubernetes

resource "kubernetes_secret" "generic_secret" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-secret"

    labels = {
      name    = "generic-secret"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "secrets"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  type = "Opaque"

  data = {
    username = "admin"
    password = "Passw0rd"
  }
}

# Validation
# kubectl get secrets -n generic-ns
# kubectl describe secret generic-secret -n generic-ns
# kubectl get secret generic-secret -n generic-ns -o jsonpath="{.data['username']}" | base64 --decode; echo
# kubectl get secret generic-secret -n generic-ns -o jsonpath="{.data['password']}" | base64 --decode; echo
