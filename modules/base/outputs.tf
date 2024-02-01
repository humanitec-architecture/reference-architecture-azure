# General outputs

output "environment" {
  description = "Name of the environment to be deployed into"
  value       = var.environment
}

# AKS outputs

output "aks_host" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.azure_aks.host
}

output "aks_cluster_ca_certificate" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.azure_aks.cluster_ca_certificate
}

output "aks_server_app_id" {
  description = "Azure Kubernetes Service AAD Server"
  value       = data.azuread_service_principal.aks.client_id
}

# Ingress outputs

output "ingress_nginx_external_ip" {
  description = "External IP address for the Nginx ingress controller"
  value       = local.ingress_address
}
