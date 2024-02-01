# Humanitec resource definition to connect the cluster to Humanitec

locals {
  ingress_address = data.kubernetes_service.ingress_nginx_controller.status[0].load_balancer[0].ingress[0].ip
}

resource "humanitec_resource_definition" "k8s_cluster_driver" {
  driver_type = "humanitec/k8s-cluster-aks"
  id          = var.cluster_name
  name        = var.cluster_name
  type        = "k8s-cluster"

  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer" : local.ingress_address
      "name" : module.azure_aks.aks_name
      "resource_group" : azurerm_resource_group.main.name
      "subscription_id" : var.subscription_id,
      "server_app_id" : data.azuread_service_principal.aks.client_id
    })
    secrets_string = jsonencode({
      "credentials" = {
        "appId" : azuread_service_principal.humanitec.client_id,
        "displayName" : azuread_application.main.display_name,
        "password" : azuread_service_principal_password.humanitec.value,
        "tenant" : azuread_service_principal.humanitec.application_tenant_id
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_cluster_driver" {
  resource_definition_id = humanitec_resource_definition.k8s_cluster_driver.id
  env_type               = var.environment
}

resource "humanitec_resource_definition" "k8s_namespace" {
  driver_type = "humanitec/static"
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
