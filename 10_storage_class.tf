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

  storage_provisioner    = var.storage_provisioner
  reclaim_policy         = var.reclaim_policy
  volume_binding_mode    = var.volume_binding_mode
  allow_volume_expansion = var.allow_volume_expansion

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
