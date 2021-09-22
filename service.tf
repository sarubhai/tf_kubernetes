# service.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes service resources in Kubernetes cluster
# A Service is an abstraction which defines a logical set of pods and a policy by which to access them

resource "kubernetes_service" "generic_nginx_svc" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-nginx-svc"

    labels = {
      name    = "generic-nginx-svc"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "svcs"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    selector = {
      name = kubernetes_deployment.generic_nginx_deploy.spec.0.template.0.metadata.0.labels.name
    }

    type = "NodePort"

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }
  }

  # lifecycle {
  #   ignore_changes = [
  #     spec[0].external_ips,
  #     spec[0].load_balancer_source_ranges
  #   ]
  # }
}

# Validation
# kubectl get services -n generic-ns
# kubectl describe service generic-nginx-svc -n generic-ns
# curl http://10.0.1.200:30080
