# outputs.tf
# Owner: Saurav Mitra
# Description: Outputs the relevant resources ID, URL values
# https://www.terraform.io/docs/configuration/outputs.html

# Ingress Load balancer
/*
output "app_load_balancer_hostname" {
  value = kubernetes_ingress.app_frontend_ingress.status.0.load_balancer.0.ingress.0.hostname
}

output "app_load_balancer_ip" {
  value = kubernetes_ingress.app_frontend_ingress.status.0.load_balancer.0.ingress.0.ip
}
*/
