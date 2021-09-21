# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes namespace resources in Kubernetes cluster

resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "${var.prefix}-ns"

    labels = {
      name = "${var.prefix}-ns"
    }
  }
}


# Validation
# kubectl get all -n webapp-ns
# kubectl get pods -n webapp-ns -o wide
# curl http://10.0.1.200:30080
