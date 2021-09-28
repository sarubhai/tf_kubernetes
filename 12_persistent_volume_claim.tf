# persistent_volume_claim.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes persistent volume claim resources in Kubernetes cluster
# This resource allows the user to request for and claim to a persistent volume

resource "kubernetes_persistent_volume_claim" "generic_pvc1" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pvc1"

    labels = {
      name    = "generic-pvc1"
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

resource "kubernetes_persistent_volume_claim" "generic_pvc2" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pvc2"

    labels = {
      name    = "generic-pvc2"
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
    volume_name        = kubernetes_persistent_volume.generic_pv2.metadata.0.name

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

resource "kubernetes_persistent_volume_claim" "generic_pvc3" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pvc3"

    labels = {
      name    = "generic-pvc3"
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
    volume_name        = kubernetes_persistent_volume.generic_pv3.metadata.0.name

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

resource "kubernetes_persistent_volume_claim" "generic_pvc4" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pvc4"

    labels = {
      name    = "generic-pvc4"
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
    volume_name        = kubernetes_persistent_volume.generic_pv4.metadata.0.name

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
# kubectl describe persistentvolumeclaim generic-pvc1 -n generic-ns
# kubectl describe persistentvolumeclaim generic-pvc2 -n generic-ns
# kubectl describe persistentvolumeclaim generic-pvc3 -n generic-ns
# kubectl describe persistentvolumeclaim generic-pvc4 -n generic-ns
