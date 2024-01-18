locals {
  aks_cluster_user_role_name = "Azure Kubernetes Service Cluster User Role"
}

data "azurerm_subscription" "main" {}

data "azuread_service_principal" "aks" {
  display_name = "Azure Kubernetes Service AAD Server"
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

# VPC and AKS cluster

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

  local_account_disabled            = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true
  rbac_aad_admin_group_object_ids = [
    azuread_group.cluster_admins.id
  ]

  oidc_issuer_enabled = true

  depends_on = [azurerm_resource_group.main]

  agents_size             = var.vm_size
  node_os_channel_upgrade = "NodeImage"
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

resource "azurerm_role_assignment" "humanitec_cluster_user_role" {
  scope                = data.azurerm_subscription.main.id
  role_definition_name = local.aks_cluster_user_role_name
  principal_id         = azuread_service_principal.humanitec.id
}

resource "azuread_group_member" "humanitec_cluster_admin" {
  group_object_id  = azuread_group.cluster_admins.id
  member_object_id = azuread_service_principal.humanitec.id
}


# Ingress controller

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"

  chart   = "ingress-nginx"
  version = "4.8.2"
  wait    = true
  timeout = 600

  set {
    type  = "string"
    name  = "controller.replicaCount"
    value = var.ingress_nginx_replica_count
  }

  set {
    type  = "string"
    name  = "controller.minAvailable"
    value = var.ingress_nginx_min_unavailable
  }

  depends_on = [module.azure_aks.node_resource_group]
}
