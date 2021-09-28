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

variable "hostname" {
  description = "The hostname of standalone kubernetes cluster."
  default     = "minikube"
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

# Storage & Path
variable "storage_provisioner" {
  description = "This Storage Provisioner Type."
  default     = "kubernetes.io/no-provisioner" #  | "k8s.io/minikube-hostpath" | "docker.io/hostpath"
}

variable "reclaim_policy" {
  description = "This Storage Reclaim Policy."
  default     = "Retain" # "Delete"/"Recycle"
}

variable "allow_volume_expansion" {
  description = "Allow Volume Expansion."
  default     = "true"
}

variable "pv1_path" {
  description = "This path to Persistent Volume Storage 1."
  default     = "/data/pv-1"
}

variable "pv2_path" {
  description = "This path to Persistent Volume Storage 2."
  default     = "/data/pv-2"
}

variable "pv3_path" {
  description = "This path to Persistent Volume Storage 3."
  default     = "/data/pv-3"
}

variable "pv4_path" {
  description = "This path to Persistent Volume Storage 4."
  default     = "/data/pv-4"
}

# Tags
variable "env" {
  description = "This environment name tag will be included in the resources."
  default     = "dev"
}

variable "owner" {
  description = "This owner name tag will be included in the owner of the resources."
  default     = "saurav_mitra"
}

variable "prefix" {
  description = "This prefix will be included in the name of the application resources."
  default     = "webapp"
}
