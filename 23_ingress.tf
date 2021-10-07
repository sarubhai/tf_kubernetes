# ingress.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes ingress resources in Kubernetes cluster
# Ingress is a collection of rules that allow inbound connections to reach the endpoints defined by a backend. 
# An Ingress can be configured to give services externally-reachable urls, load balance traffic, terminate SSL, offer name based virtual hosting etc

# NOT WORKING FROM TF
/*
resource "kubernetes_ingress" "generic_nginx_ing" {
  # wait_for_load_balancer = true

  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-ing"

    labels = {
      name    = "generic-nginx-ing"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "ing"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
      # "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    backend {
      service_name = kubernetes_service.generic_nginx_svc.metadata.0.name
      service_port = 80
    }

    rule {
      http {
        path {
          path = "/"

          backend {
            service_name = kubernetes_service.generic_nginx_svc.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}
*/
