# service.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service resources in Kubernetes cluster

/*
resource "kubernetes_ingress" "app_frontend_ingress" {
  wait_for_load_balancer = true

  metadata {
    namespace = kubernetes_namespace.app_ns.metadata.0.name
    name      = "${var.prefix}-frontend-ingress"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }

    labels = {
      name       = "${var.prefix}-frontend-ingress"
      instance   = "${var.prefix}-frontend-ingress"
      version    = "v1"
      component  = "webserver-ingress"
      part-of    = "webapp"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"

          backend {
            service_name = kubernetes_service.app_frontend_svc.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}
*/
