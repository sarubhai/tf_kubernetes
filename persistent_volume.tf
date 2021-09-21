# persistent_volume.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes persistent volume resources in Kubernetes cluster

resource "kubernetes_persistent_volume" "app_backend_pv" {
  metadata {
    name = "${var.prefix}-backend-pv1"

    labels = {
      type       = "local"
      name       = "${var.prefix}-backend-pv1"
      instance   = "${var.prefix}-backend-pv1"
      version    = "v1"
      component  = "webserver-backend"
      part-of    = "webapp"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    capacity = {
      storage = "2Gi"
    }

    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "local"

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = ["ip-10-0-1-200"]
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = "/data/pv-1"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "app_backend_pv_claim" {
  metadata {
    name = "${var.prefix}-backend-pv1-claim"

    labels = {
      name       = "${var.prefix}-backend-pv1-claim"
      instance   = "${var.prefix}-backend-pv1-claim"
      version    = "v1"
      component  = "webserver-backend"
      part-of    = "webapp"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "local"

    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.app_backend_pv.metadata.0.name
  }
}
