# deployment.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes deployment resources in Kubernetes cluster

resource "kubernetes_deployment" "app_frontend_deploy" {
  metadata {
    namespace = kubernetes_namespace.app_ns.metadata.0.name
    name      = "${var.prefix}-nginx-deploy"

    labels = {
      name       = "${var.prefix}-nginx-deploy"
      instance   = "nginx-xxxxxx"
      version    = "1.21"
      component  = "webserver"
      part-of    = "wordpress"
      managed-by = "terraform"
      created-by = var.owner
    }

    annotations = {
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "${var.prefix}-nginx-deploy"
      }
    }

    template {
      metadata {
        labels = {
          name = "${var.prefix}-nginx-deploy"
        }
      }

      spec {
        container {
          image = "nginx:1.21"
          name  = "nginx"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "1"
              memory = "512Mi"
            }

            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}
