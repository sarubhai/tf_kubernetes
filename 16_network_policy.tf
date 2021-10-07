# network_policy.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes network policy resources in Kubernetes cluster
# Kubernetes supports network policies to specify how groups of pods are allowed to communicate with each other and with other network endpoints.
# NetworkPolicy resources use labels to select pods and define rules which specify what traffic is allowed to the selected pods.

# COMMENTED FOR DEMO
/*
resource "kubernetes_network_policy" "generic_netpol" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-maintenance-netpol"

    labels = {
      name    = "generic-maintenance-netpol"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component  = "netpol"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    pod_selector {
      match_labels = {
        mode = "maintenance"
      }
    }

    # ingress {

    #   ports {
    #     port     = "5432"
    #     protocol = "TCP"
    #   }

    #   from {
    #     namespace_selector {
    #       match_labels = {
    #         name = "web"
    #       }
    #     }
    #   }

    #   from {
    #     ip_block {
    #       cidr = "10.0.0.0/8"
    #       except = [
    #         "10.0.0.0/24",
    #         "10.0.1.0/24",
    #       ]
    #     }
    #   }
    # }

    # egress {} # single empty rule to allow all egress traffic

    policy_types = ["Ingress", "Egress"]
  }
}
*/


# Validation
# Before Enabling Network Policy
# kubectl run busybox1 --image=busybox --restart=Never -n generic-ns -- sleep 3600
# kubectl run busybox2 --image=busybox --restart=Never -n generic-ns -l="mode=ops" -- sleep 3600
# kubectl run busybox3 --image=busybox --restart=Never -n generic-ns -l="mode=maintenance" -- sleep 3600
# kubectl get pods -o wide -n generic-ns
# kubectl get pods -l mode=maintenance -o wide -n generic-ns
# kubectl exec -ti busybox1 -n generic-ns -- ping -c3 <busybox2_IP>
# kubectl exec -ti busybox1 -n generic-ns -- ping -c3 <busybox3_IP>

# After Enabling Network Policy
# kubectl get networkpolicies -n generic-ns
# kubectl describe networkpolicy generic-maintenance-netpol -n generic-ns

# Cleanup
# kubectl delete pod busybox1 busybox2 busybox3 -n generic-ns
