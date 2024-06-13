locals {
  cloud_provider = "azure"
}

# Configure GitHub variables & secrets for all scaffolded apps

resource "github_actions_organization_variable" "backstage_cloud_provider" {
  variable_name = "CLOUD_PROVIDER"
  visibility    = "all"
  value         = local.cloud_provider
}

resource "github_actions_organization_variable" "backstage_azure_client_id" {
  variable_name = "AZURE_CLIENT_ID"
  visibility    = "all"
  value         = azurerm_user_assigned_identity.github_oidc_identity.client_id
}

resource "github_actions_organization_variable" "backstage_azure_tenant_id" {
  variable_name = "AZURE_TENANT_ID"
  visibility    = "all"
  value         = azurerm_user_assigned_identity.github_oidc_identity.tenant_id
}

resource "github_actions_organization_variable" "backstage_azure_subscription_id" {
  variable_name = "AZURE_SUBSCRIPTION_ID"
  visibility    = "all"
  value         = var.subscription_id
}

resource "github_actions_organization_variable" "backstage_azure_acr_name" {
  variable_name = "AZURE_ACR_NAME"
  visibility    = "all"
  value         = var.az_container_registry_name
}

resource "github_actions_organization_variable" "backstage_humanitec_org_id" {
  variable_name = "HUMANITEC_ORG_ID"
  visibility    = "all"
  value         = var.humanitec_org_id
}

resource "github_actions_organization_secret" "backstage_humanitec_token" {
  secret_name     = "HUMANITEC_TOKEN"
  visibility      = "all"
  plaintext_value = var.humanitec_ci_service_user_token
}
