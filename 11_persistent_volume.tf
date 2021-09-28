# persistent_volume.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes persistent volume resources in Kubernetes cluster
# A PersistentVolume provides networked storage in the cluster

resource "kubernetes_persistent_volume" "generic_pv1" {
  metadata {
    name = "generic-pv1"

    labels = {
      name    = "generic-pv1"
      env     = var.env
      version = "v1"
      type    = "local"
    }

    annotations = {
      component  = "pv"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = kubernetes_storage_class.generic_sc.metadata.0.name
    persistent_volume_reclaim_policy = var.reclaim_policy

    capacity = {
      storage = "2Gi"
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = [var.hostname]
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = var.pv1_path
      }
    }
  }
}

resource "kubernetes_persistent_volume" "generic_pv2" {
  metadata {
    name = "generic-pv2"

    labels = {
      name    = "generic-pv2"
      env     = var.env
      version = "v1"
      type    = "local"
    }

    annotations = {
      component  = "pv"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = kubernetes_storage_class.generic_sc.metadata.0.name
    persistent_volume_reclaim_policy = var.reclaim_policy

    capacity = {
      storage = "2Gi"
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = [var.hostname]
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = var.pv2_path
      }
    }
  }
}

resource "kubernetes_persistent_volume" "generic_pv3" {
  metadata {
    name = "generic-pv3"

    labels = {
      name    = "generic-pv3"
      env     = var.env
      version = "v1"
      type    = "local"
    }

    annotations = {
      component  = "pv"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = kubernetes_storage_class.generic_sc.metadata.0.name
    persistent_volume_reclaim_policy = var.reclaim_policy

    capacity = {
      storage = "2Gi"
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = [var.hostname]
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = var.pv3_path
      }
    }
  }
}

resource "kubernetes_persistent_volume" "generic_pv4" {
  metadata {
    name = "generic-pv4"

    labels = {
      name    = "generic-pv4"
      env     = var.env
      version = "v1"
      type    = "local"
    }

    annotations = {
      component  = "pv"
      part-of    = "generic"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  spec {
    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = kubernetes_storage_class.generic_sc.metadata.0.name
    persistent_volume_reclaim_policy = var.reclaim_policy

    capacity = {
      storage = "2Gi"
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = [var.hostname]
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = var.pv4_path
      }
    }

    # mount_options = []
  }

  # lifecycle {
  #   ignore_changes = [
  #     metadata.0.resource_version,
  #     spec[0].mount_options,
  #     spec[0].claim_ref
  #   ]
  # }
}


# Validation
# kubectl get persistentvolumes
# kubectl describe persistentvolume generic-pv1
# kubectl describe persistentvolume generic-pv2
# kubectl describe persistentvolume generic-pv3
# kubectl describe persistentvolume generic-pv4
