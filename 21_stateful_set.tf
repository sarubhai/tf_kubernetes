# stateful_set.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes stateful set resources in Kubernetes cluster
# Manages the deployment and scaling of a set of Pods , and provides guarantees about the ordering and uniqueness of these Pods.


resource "kubernetes_stateful_set" "generic_nginx_sts" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-sts"

    labels = {
      name    = "generic-nginx-sts"
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
    replicas               = 1
    revision_history_limit = 5

    selector {
      match_labels = {
        name = "generic-nginx-sts-po"
      }
    }

    service_name = "generic-nginx-sts"

    template {
      metadata {
        labels = {
          name    = "generic-nginx-sts-po"
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
          image = "nginx:1.21"
          name  = "nginx"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "static-asset"
            mount_path = "/usr/share/nginx/html"
            read_only  = true
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

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }

        volume {
          name = "static-asset"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.generic_pvc1.metadata.0.name
            read_only  = true
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
# kubectl describe statefulset generic-nginx-sts -n generic-ns
