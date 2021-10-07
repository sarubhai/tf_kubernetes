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
      component  = "svc"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    selector = {
      # name = "generic-nginx-ws-po"
      name = kubernetes_deployment.generic_nginx_deploy.spec.0.template.0.metadata.0.labels.name
    }

    type             = "NodePort"
    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
      protocol    = "TCP"
    }
  }
}


# Postgres
resource "kubernetes_service" "generic_postgres_svc" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-postgres-svc"

    labels = {
      name    = "generic-postgres-svc"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "svc"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    selector = {
      # name = "generic-postgres-sts-po"
      name = kubernetes_stateful_set.generic_postgres_sts.spec.0.template.0.metadata.0.labels.name
    }

    type             = "NodePort"
    session_affinity = "ClientIP"

    port {
      port        = 5432
      target_port = 5432
      node_port   = 32345
      protocol    = "TCP"
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
# curl http://minikube.demo:30080/

# Postgres
# psql -h 127.0.0.1 -p 32345 -U adminuser -d dev
