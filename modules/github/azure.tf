locals {
  name              = "gha-acr-push"
  github_issuer_url = "https://token.actions.githubusercontent.com"
}

# User for GHA allowed to push images using OpenID Connect (OIDC) so we don't need to store credentials in GitHub
# Reference https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure

resource "azurerm_user_assigned_identity" "github_oidc_identity" {
  name                = local.name
  location            = var.az_resource_group_location
  resource_group_name = var.az_resource_group_name
}

resource "azurerm_federated_identity_credential" "github_oidc_identity" {
  name                = "github-action-identity"
  resource_group_name = var.az_resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = local.github_issuer_url
  subject             = "repository_owner:${var.github_org_id}" # configured in github_actions_organization_oidc_subject_claim_customization_template
  parent_id           = azurerm_user_assigned_identity.github_oidc_identity.id
}

resource "azurerm_role_assignment" "github_oidc_identity_acr" {
  scope                = var.az_container_registry_id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.github_oidc_identity.principal_id
}
