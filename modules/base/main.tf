data "azuread_service_principal" "aks" {
  # The ID of the managed "Azure Kubernetes Service AAD Server" application
  # https://learn.microsoft.com/en-us/azure/aks/kubelogin-authentication#how-to-use-kubelogin-with-aks
  client_id = "6dae42f8-4368-4678-94ff-3960e28e3630"
}

resource "azuread_group" "cluster_admins" {
  display_name     = "Ref-Arch cluster admins"
  mail_enabled     = false
  security_enabled = true
}

data "azuread_client_config" "current" {}

resource "azuread_group_member" "cluster_admins" {
  group_object_id  = azuread_group.cluster_admins.id
  member_object_id = data.azuread_client_config.current.object_id
}

# RG and AKS cluster

resource "azurerm_resource_group" "main" {
  location = var.location
  name     = var.resource_group_name
}

module "azure_aks" {
  source  = "Azure/aks/azurerm"
  version = "~> 7"

  prefix                    = var.cluster_name
  resource_group_name       = azurerm_resource_group.main.name
  automatic_channel_upgrade = "stable"

  local_account_disabled = true

  # Configure as "Azure AD authentication with Azure RBAC"
  # https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true
  rbac_aad_azure_rbac_enabled       = true
  rbac_aad_admin_group_object_ids = [
    azuread_group.cluster_admins.id
  ]

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_contributor_role_assigned_subnet_ids = {
    resource_group = azurerm_resource_group.main.id
  }

  depends_on = [azurerm_resource_group.main]

  agents_size             = var.vm_size
  node_os_channel_upgrade = "NodeImage"

  attached_acr_id_map = {
    main = azurerm_container_registry.acr.id
  }
}

# Service Principal used by Humanitec to access the AKS cluster

resource "azuread_application" "main" {
  display_name = var.cluster_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "humanitec" {
  client_id = azuread_application.main.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "humanitec" {
  service_principal_id = azuread_service_principal.humanitec.id
}

# Required to fetch AKS credentials
resource "azurerm_role_assignment" "humanitec_cluster_user" {
  scope                = module.azure_aks.aks_id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_service_principal.humanitec.id
}

# Admin permissions for the entire cluster
resource "azurerm_role_assignment" "humanitec_cluster_admin_permissions" {
  scope                = module.azure_aks.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = azuread_service_principal.humanitec.id
}
