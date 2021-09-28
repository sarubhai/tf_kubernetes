# cron_job.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes cron job resources in Kubernetes cluster
# A Cron Job creates Jobs on a time-based schedule.
# One CronJob object is like one line of a crontab (cron table) file. It runs a job periodically on a given schedule, written in Cron format.

resource "kubernetes_cron_job" "generic_cj" {
  metadata {
    namespace = kubernetes_namespace.generic_ns.metadata.0.name
    name      = "generic-busybox-cj"

    labels = {
      name    = "generic-busybox-cj"
      env     = var.env
      version = "v1"
    }

    annotations = {
      component     = "cj"
      part-of       = "generic"
      managed-by    = "terraform"
      created-by    = var.owner
      imageregistry = "https://hub.docker.com/"
    }
  }

  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "*/5  * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              image   = "busybox"
              name    = "generic-busybox-cj"
              command = ["sh"]
              args    = ["-c", "echo Logging from CronJob at: `date \"+%F %H:%M:%S\"` >> /output/cron_output.log"]

              volume_mount {
                name       = "write-log"
                mount_path = "/output"
                read_only  = false
              }
            }

            volume {
              name = "write-log"
              persistent_volume_claim {
                claim_name = kubernetes_persistent_volume_claim.generic_pvc4.metadata.0.name
                read_only  = false
              }
            }
          }
        }
      }
    }
  }
}


# Validation
# kubectl get cronjobs -n generic-ns
# kubectl describe cronjob generic-busybox-cj -n generic-ns
