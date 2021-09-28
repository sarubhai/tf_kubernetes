# limit_range.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes limit range resources in Kubernetes cluster
# Limit Range sets resource usage limits (e.g. memory, cpu, storage) for supported kinds of resources in a namespace.

/*
resource "kubernetes_limit_range" "generic_limits" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pod-limits"

    labels = {
      name    = "generic-pod-limits"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "limits"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = "200m"
        memory = "50Mi"
      }
    }
    limit {
      type = "Container"
      default = {
        cpu    = "50m"
        memory = "24Mi"
      }
    }
  }
}
*/


# Validation
# Before Enabling Limit Range
# kubectl run nginx1 --image=nginx --restart=Never -n generic-ns
# kubectl describe pod nginx1 -n generic-ns

# After Enabling Limit Range
# kubectl get limitranges -n generic-ns
# kubectl describe limitrange generic-pod-limits -n generic-ns
# kubectl run nginx2 --image=nginx --restart=Never -n generic-ns
# kubectl describe pod nginx2 -n generic-ns
# Verify Limits & Requests

# Cleanup
# kubectl delete pod nginx1 nginx2 -n generic-ns
