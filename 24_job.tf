# job.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes job resources in Kubernetes cluster
# A Job creates one or more Pods and ensures that a specified number of them successfully terminate. 
# As pods successfully complete, the Job tracks the successful completions.

resource "kubernetes_job" "generic_jobs" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-busybox-jobs"

    labels = {
      name    = "generic-busybox-jobs"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "jobs"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    template {
      metadata {}
      spec {
        container {
          image   = "busybox"
          name    = "generic-busybox-jobs"
          command = ["sh"]
          args    = ["-c", "echo Logging from Job at: `date \"+%F %H:%M:%S\"` >> /output/job_output.log"]

          volume_mount {
            name       = "write-log"
            mount_path = "/output"
            read_only  = false
          }
        }

        restart_policy = "Never"

        volume {
          name = "write-log"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.generic_pvc3.metadata.0.name
            read_only  = false
          }
        }
      }
    }

    backoff_limit = 4
  }

  wait_for_completion = false
}


# Validation
# kubectl get jobs -n generic-ns
# kubectl describe job generic-busybox-jobs -n generic-ns
