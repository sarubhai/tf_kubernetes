# stateful_set.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes stateful set resources in Kubernetes cluster
# Manages the deployment and scaling of a set of Pods , and provides guarantees about the ordering and uniqueness of these Pods.

resource "kubernetes_stateful_set" "generic_postgres_sts" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-postgres-sts"

    labels = {
      name    = "generic-postgres-sts"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "sts"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    pod_management_policy  = "Parallel"
    replicas               = 2
    revision_history_limit = 5

    selector {
      match_labels = {
        name = "generic-postgres-sts-po"
      }
    }

    service_name = "generic-postgres-sts"

    template {
      metadata {
        labels = {
          name    = "generic-postgres-sts-po"
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
        service_account_name = "default"

        container {
          image = "postgres:latest"
          name  = "postgres"

          port {
            container_port = 5432
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.postgres_cm.metadata.0.name
            }
          }

          volume_mount {
            name       = "pgdata"
            mount_path = "/data"
            read_only  = false
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "100Mi"
            }

            requests = {
              cpu    = "200m"
              memory = "50Mi"
            }
          }
        }

        volume {
          name = "pgdata"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.generic_pvc_postgres.metadata.0.name
            read_only  = false
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      spec[0].template[0].spec[0].container[0].volume_mount,
      # spec[0].template[0].spec[0].node_selector
    ]
  }
}


# Validation
# kubectl get statefulsets -n generic-ns
# kubectl describe statefulset generic-postgres-sts -n generic-ns
