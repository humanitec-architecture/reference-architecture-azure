# General outputs

output "environment" {
  description = "Name of the environment to be deployed into"
  value       = var.environment
}

output "az_resource_group_name" {
  description = "Name of the created azure resource group"
  value       = azurerm_resource_group.main.name
}

output "az_resource_group_location" {
  description = "Location of the created azure resource group"
  value       = azurerm_resource_group.main.location
}

output "az_container_registry_name" {
  description = "Name of the created azure container registry"
  value       = azurerm_container_registry.acr.name
}

output "az_container_registry_id" {
  description = "ID of the created azure container registry"
  value       = azurerm_container_registry.acr.id
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

output "aks_oidc_issuer_url" {
  description = "Issuer URL for the OpenID Connect discovery endpoint"
  value       = module.azure_aks.oidc_issuer_url
}

# Ingress outputs

output "ingress_nginx_external_ip" {
  description = "External IP address for the Nginx ingress controller"
  value       = azurerm_public_ip.ingress.ip_address
}
