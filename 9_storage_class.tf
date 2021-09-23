# storage_class.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes storage class resources in Kubernetes cluster
# A StorageClass provides the foundation of dynamic provisioning, to define abstractions for the underlying storage platform

resource "kubernetes_storage_class" "generic_sc" {
  metadata {
    name = "generic-sc"

    labels = {
      name    = "generic-sc"
      env     = var.env
      version = "v1"
      type    = "local"
    }

    annotations = {
      component  = "sc"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  # storage_provisioner    = "k8s.io/minikube-hostpath"
  storage_provisioner    = "kubernetes.io/no-provisioner"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "Immediate"
  allow_volume_expansion = "true"
  # mount_options = []
  # parameters = {}

  # lifecycle {
  #   ignore_changes = [
  #     mount_options,
  #     parameters
  #   ]
  # }
}

# Validation
# kubectl get storageclasses
# kubectl describe storageclass generic-sc
