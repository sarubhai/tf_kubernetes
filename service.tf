# service.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service resources in Kubernetes cluster

resource "kubernetes_service" "app_frontend_svc" {
  metadata {
    namespace = kubernetes_namespace.app_ns.metadata.0.name
    name      = "${var.prefix}-frontend-svc"

    labels = {
      name       = "${var.prefix}-frontend-svc"
      instance   = "${var.prefix}-frontend-svc"
      version    = "v1"
      component  = "webserver-svc"
      part-of    = "webapp"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    selector = {
      name = kubernetes_deployment.app_frontend_deploy.spec.0.template.0.metadata.0.labels.name
    }

    type = "NodePort"

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    external_ips                = null
    load_balancer_source_ranges = null
  }
}
