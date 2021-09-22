# persistent_volume_claim.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes persistent volume claim resources in Kubernetes cluster
# This resource allows the user to request for and claim to a persistent volume

resource "kubernetes_persistent_volume_claim" "generic_pv1_claim" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pv1-claim"

    labels = {
      name    = "generic-pv1-claim"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "pvc"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class.generic_sc.metadata.0.name
    volume_name        = kubernetes_persistent_volume.generic_pv1.metadata.0.name

    resources {
      limits = {
        storage = "2Gi"
      }

      requests = {
        storage = "1Gi"
      }
    }
  }
}

# Validation
# kubectl get persistentvolumeclaims -n generic-ns
# kubectl describe persistentvolumeclaim generic-pv1-claim -n generic-ns
