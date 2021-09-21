# Name: provider.tf
# Owner: Saurav Mitra
# Description: This terraform config will Configure Terraform Providers
# https://www.terraform.io/docs/language/providers/requirements.html

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Configure Terraform Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs

# $ export KUBE_CONFIG_PATH="KubeConfigFilePath"
# $ export KUBE_CTX="ContextName"
# $ export KUBE_INSECURE=true

provider "kubernetes" {
  # Configuration options
  config_path    = var.config_path
  config_context = var.config_context
  # insecure       = true
}
