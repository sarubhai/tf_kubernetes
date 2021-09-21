# variables.tf
# Owner: Saurav Mitra
# Description: Variables used by terraform config to create the application resources in Kubernetes cluster
# https://www.terraform.io/docs/configuration/variables.html

# Cluster Config
variable "config_path" {
  description = "Path to kube config file."
}

variable "config_context" {
  description = "Context to choose from the config file."
  default     = "default"
}

/*
variable "cluster_endpoint" {
  description = "The hostname URI of the Kubernetes API."
  default     = "https://127.0.0.1:8443"
}

variable "cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication."
}

variable "client_certificate" {
  description = "PEM-encoded client certificate for TLS authentication."
}

variable "client_key" {
  description = "PEM-encoded client certificate key for TLS authentication."
}
*/


# Tags
variable "prefix" {
  description = "This prefix will be included in the name of the resources."
  default     = "webapp"
}

variable "owner" {
  description = "This owner name tag will be included in the owner of the resources."
  default     = "saurav_mitra"
}

