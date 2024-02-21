# Configure GitHub variables & secrets for Backstage itself and for all scaffolded apps

locals {
  github_app_credentials_file = "github-app-credentials.json"
  github_app_credentials      = jsondecode(file("${path.module}/${local.github_app_credentials_file}"))
  github_app_id               = local.github_app_credentials["appId"]
  github_app_client_id        = local.github_app_credentials["clientId"]
  github_app_client_secret    = local.github_app_credentials["clientSecret"]
  github_app_private_key      = local.github_app_credentials["privateKey"]
  github_webhook_secret       = local.github_app_credentials["webhookSecret"]
}

locals {
  backstage_repo = "backstage"
}

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
  value         = module.base.az_container_registry_name
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

# Backstage repository itself

resource "github_repository" "backstage" {
  name        = local.backstage_repo
  description = "Backstage"

  visibility = "public"

  template {
    owner      = "humanitec-architecture"
    repository = "backstage"
  }

  depends_on = [
    module.base,
    humanitec_application.backstage,
    humanitec_resource_definition_criteria.backstage_postgres,
    github_actions_organization_secret.backstage_humanitec_token,
  ]
}

# Required as Azure doesn't support wildcards in scopes https://github.com/Azure/azure-workload-identity/issues/373
# More details in https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#customizing-the-token-claims
resource "github_actions_repository_oidc_subject_claim_customization_template" "backstage" {
  repository         = github_repository.backstage.name
  use_default        = false
  include_claim_keys = ["repository_owner"]
}
