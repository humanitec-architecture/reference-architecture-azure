# Humanitec resource definition to connect the cluster to Humanitec

resource "humanitec_resource_account" "cluster_account" {
  id   = var.cluster_name
  name = var.cluster_name
  type = "azure"

  credentials = jsonencode({
    "azure_identity_tenant_id" : azuread_service_principal.humanitec.application_tenant_id
    "azure_identity_client_id" : azuread_service_principal.humanitec.client_id
  })
}

resource "humanitec_resource_definition" "k8s_cluster_driver" {
  driver_type = "humanitec/k8s-cluster-aks"
  id          = var.cluster_name
  name        = var.cluster_name
  type        = "k8s-cluster"

  driver_account = humanitec_resource_account.cluster_account.id
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer" : azurerm_public_ip.ingress.ip_address
      "name" : module.azure_aks.aks_name
      "resource_group" : azurerm_resource_group.main.name
      "subscription_id" : var.subscription_id,
      "server_app_id" : data.azuread_service_principal.aks.client_id
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_cluster_driver" {
  resource_definition_id = humanitec_resource_definition.k8s_cluster_driver.id
  env_type               = var.environment
}

resource "humanitec_resource_definition" "k8s_namespace" {
  driver_type = "humanitec/echo"
  id          = "default-namespace"
  name        = "default-namespace"
  type        = "k8s-namespace"

  driver_inputs = {
    values_string = jsonencode({
      "namespace" = "$${context.app.id}-$${context.env.id}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_namespace" {
  resource_definition_id = humanitec_resource_definition.k8s_namespace.id
}

# in-cluster postgres

module "default_postgres" {
  source = "github.com/humanitec-architecture/resource-packs-in-cluster?ref=v2024-06-05//humanitec-resource-defs/postgres/basic"

  prefix = "default-"
}

resource "humanitec_resource_definition_criteria" "default_postgres" {
  resource_definition_id = module.default_postgres.id
  env_type               = var.environment
}

module "default_mysql" {
  source = "github.com/humanitec-architecture/resource-packs-in-cluster?ref=v2024-06-05//humanitec-resource-defs/mysql/basic"

  prefix = "default-"
}

resource "humanitec_resource_definition_criteria" "default_mysql" {
  resource_definition_id = module.default_mysql.id
  env_type               = var.environment
}
