# resource_quota.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes resource quota resources in Kubernetes cluster
# A resource quota provides constraints that limit aggregate resource consumption per namespace.
# It can limit the quantity of objects that can be created in a namespace by type, 
# as well as the total amount of compute resources that may be consumed by resources in that project.

resource "kubernetes_resource_quota" "generic_quota" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-pod-quota"

    labels = {
      name    = "generic-pod-quota"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "quota"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    hard = {
      pods = 4
    }
    scopes = ["BestEffort"]
  }
}


# Validation
# kubectl get resourcequotas -n generic-ns
# kubectl describe resourcequota generic-pod-quota -n generic-ns
# kubectl get pods -n generic-ns
# kubectl run nginx1 --image=nginx --restart=Never -n generic-ns
# kubectl run nginx2 --image=nginx --restart=Never -n generic-ns
# kubectl run nginx3 --image=nginx --restart=Never -n generic-ns
# kubectl run nginx4 --image=nginx --restart=Never -n generic-ns
# kubectl run nginx5 --image=nginx --restart=Never -n generic-ns
# kubectl delete pod nginx1 nginx2 nginx3 nginx4 -n generic-ns
