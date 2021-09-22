# config_map.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes config map resources in Kubernetes cluster
# ConfigMap store fine-grained information like individual properties or coarse-grained information like entire config files or JSON blobs. 
# The resource provides mechanisms to inject containers with configuration data, while keeping containers agnostic of Kubernetes

resource "kubernetes_config_map" "generic_config_map" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-config-map"

    labels = {
      name    = "generic-config-map"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "configmaps"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  data = {
    api_hostname = "api.example.com:443"
    db_hostname  = "db.example.com:5432"
  }

  # binary_data = {}

  # lifecycle {
  #   ignore_changes = [binary_data]
  # }
}

# Validation
# kubectl get configmaps -n generic-ns
# kubectl describe configmaps generic-config-map -n generic-ns
# kubectl get configmaps generic-config-map -n generic-ns -o jsonpath="{.data['api_hostname']}"; echo
# kubectl get configmaps generic-config-map -n generic-ns -o jsonpath="{.data['db_hostname']}"; echo
