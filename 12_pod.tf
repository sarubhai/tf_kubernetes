# pod.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes pod resources in Kubernetes cluster
# A pod is a group of one or more containers
# For Example Only; Run Pod as part of Replication Controller, Deployment etc.

resource "kubernetes_pod" "generic_busybox_po" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-busybox-po"

    labels = {
      name    = "generic-busybox-po"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "po"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    container {
      image   = "busybox"
      name    = "generic-busybox"
      command = ["sh"]
      args    = ["-c", "while true; do echo Logging at: `date \"+%F %H:%M:%S\"` : host=$DB_HOST : user=$DB_USER : pass=$DB_PASS  >> /output/output.log; sleep 120; done"]

      env {
        name = "DB_HOST"

        value_from {
          config_map_key_ref {
            name = kubernetes_config_map.generic_cm.metadata.0.name
            key  = "db_hostname"
          }
        }
      }

      env {
        name = "DB_USER"

        value_from {
          secret_key_ref {
            name = kubernetes_secret.generic_secret.metadata.0.name
            key  = "username"
          }
        }
      }

      env {
        name = "DB_PASS"

        value_from {
          secret_key_ref {
            name = kubernetes_secret.generic_secret.metadata.0.name
            key  = "password"
          }
        }
      }

      # port {
      #   container_port = 22
      # }

      volume_mount {
        name       = "write-log"
        mount_path = "/output"
        read_only  = false
      }

      resources {
        limits = {
          cpu    = "0.2"
          memory = "50Mi"
        }

        requests = {
          cpu    = "200m"
          memory = "50Mi"
        }
      }
    }

    volume {
      name = "write-log"
      persistent_volume_claim {
        claim_name = kubernetes_persistent_volume_claim.generic_pvc2.metadata.0.name
        read_only  = false
      }
    }

    # node_selector = {}
  }

  lifecycle {
    ignore_changes = [
      spec[0].volume,
      spec[0].container[0].volume_mount,
      # spec[0].node_selector,
      metadata[0].resource_version
    ]
  }
}


# Validation
# kubectl get pods -n generic-ns
# kubectl describe pod generic-busybox-po -n generic-ns
