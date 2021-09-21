# secret.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the kubernetes secret resources in Kubernetes cluster

resource "kubernetes_secret" "app_secret" {
  metadata {
    name = "${var.prefix}-secret"

    labels = {
      name       = "${var.prefix}-secret"
      instance   = "${var.prefix}-secret"
      version    = "v1"
      component  = "webserver-backend"
      part-of    = "webapp"
      managed-by = "terraform"
      created-by = var.owner
    }
  }

  type = "Opaque"

  data = {
    username = "admin"
    password = "Passw0rd"
  }
}
