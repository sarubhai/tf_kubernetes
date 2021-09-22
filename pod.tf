# pod.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes pod resources in Kubernetes cluster
# A pod is a group of one or more containers

resource "kubernetes_pod" "generic_nginx_pod" {
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

    # node_selector = {}
  }

  lifecycle {
    ignore_changes = [
      spec[0].container[0].volume_mount,
      # spec[0].node_selector
      metadata[0].resource_version
    ]
  }
}

# Validation
# kubectl get pods -n generic-ns
# kubectl describe pod generic-nginx-pod -n generic-ns
