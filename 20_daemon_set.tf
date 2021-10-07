# daemon_set.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes daemon set resources in Kubernetes cluster
# A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. 
# As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected.

resource "kubernetes_daemonset" "generic_nginx_ds" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-ds"

    labels = {
      name    = "generic-nginx-ds"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "ds"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    selector {
      match_labels = {
        name = "generic-nginx-ds-po"
      }
    }

    template {
      metadata {
        labels = {
          name    = "generic-nginx-ds-po"
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
            claim_name = kubernetes_persistent_volume_claim.generic_pvc2.metadata.0.name
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
# kubectl get daemonsets -n generic-ns
# kubectl describe daemonset generic-nginx-ds -n generic-ns
# kubectl get pods -o wide | generic-nginx-ds-
# curl <IP>
