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
      component     = "deploy"
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
        name = "generic-nginx-ws-po"
      }
    }

    template {
      metadata {
        labels = {
          name    = "generic-nginx-ws-po"
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
# kubectl get deployments -n generic-ns
# kubectl describe deployment generic-nginx-deploy -n generic-ns
# kubectl get pods -o wide | grep generic-nginx-deploy-
# curl <IP>
