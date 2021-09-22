# deployment.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes deployment resources in Kubernetes cluster
# A Deployment ensures that a specified number of pod “replicas” are running at any one time

resource "kubernetes_deployment" "generic_nginx_deploy" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-deploy"

    labels = {
      name    = "generic-nginx-deploy"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "deployments"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "generic-nginx-ws-pod"
      }
    }

    template {
      metadata {
        labels = {
          name    = "generic-nginx-ws-pod"
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
          name    = "nginx"
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
# kubectl get deployments -n generic-ns
# kubectl describe deployment generic-nginx-deploy -n generic-ns
