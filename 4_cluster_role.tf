# cluster_role.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes cluster role resources in Kubernetes cluster
# A ClusterRole contains rules that represent a set of permissions applicable at the cluster level and to all namespaces

# Generic
resource "kubernetes_cluster_role" "generic_ro_cluster_role" {
  metadata {
    name = "generic-ro-cluster-role"

    labels = {
      name    = "generic-ro-cluster-role"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "clusterroles"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  rule {
    resources         = ["pods"]
    verbs             = ["get", "list", "watch"]
    api_groups        = [""]
    non_resource_urls = []
    resource_names    = []
  }
}

# Validation
# kubectl get clusterroles
# kubectl describe clusterrole generic-ro-cluster-role
