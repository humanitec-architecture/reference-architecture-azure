output "aks_cluster_issuer_url" {
  description = "Issuer URL for the OpenID Connect discovery endpoint"
  value       = module.base.aks_oidc_issuer_url
}
