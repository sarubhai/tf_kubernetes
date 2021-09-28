# horizontal_pod_autoscaler.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes horizontal pod autoscaler resources in Kubernetes cluster
# Horizontal Pod Autoscaler automatically scales the number of pods in a replication controller, deployment or replica set based on observed CPU utilization.

/*
resource "kubernetes_horizontal_pod_autoscaler" "example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    max_replicas = 10
    min_replicas = 8

    scale_target_ref {
      kind = "Deployment"
      name = "MyApp"
    }
  }
}
*/


# Validation
