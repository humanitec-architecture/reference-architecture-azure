resource "azurerm_public_ip" "ingress" {
  name                = "${var.resource_group_name}-ingress"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
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
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    type  = "string"
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-pip-name"
    value = azurerm_public_ip.ingress.name
  }

  set {
    type  = "string"
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = azurerm_resource_group.main.name
  }

  set {
    type  = "string"
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }

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
