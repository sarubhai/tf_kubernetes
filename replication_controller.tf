# replication_controller.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes replication controller resources in Kubernetes cluster
# A ReplicationController ensures that a specified number of pod “replicas” are running at any one time

resource "kubernetes_replication_controller" "generic_nginx_rc" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-rc"

    labels = {
      name    = "generic-nginx-rc"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "rc"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    replicas = 1

    selector = {
      name = kubernetes_pod.generic_nginx_pod.metadata.0.name
    }

    template {
      metadata {
        namespace = kubernetes_namespace.generic_ns.metadata.0.name
        name      = "generic-nginx-pod"

        labels = {
          name    = "generic-nginx-pod"
          env     = var.env
          version = "v1"
        }

        annotations = {
          component     = "pods"
          part-of       = "generic"
          managed-by    = "terraform"
          created-by    = var.owner
          imageregistry = "https://hub.docker.com/"
        }
      }

      spec {
        container {
          image   = "nginx:1.21"
          name    = "generic-nginx"
          args    = []
          command = []

          port {
            container_port = 80
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
# kubectl get rc -n generic-ns
# kubectl describe rc generic-nginx-rc -n generic-ns
