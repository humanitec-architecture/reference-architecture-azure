terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.11"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.87"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.38"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
  required_version = ">= 1.3.0"
}

provider "humanitec" {
  org_id = var.humanitec_org_id
}

provider "github" {
  owner = var.github_org_id
}

provider "azapi" {
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "azuread" {}

provider "kubernetes" {
  host = module.base.aks_host

  cluster_ca_certificate = base64decode(module.base.aks_cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    # This requires the kubelogin to be installed locally where Terraform is executed
    args = ["get-token", "--server-id", module.base.aks_server_app_id, "--login", "azurecli"]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.base.aks_host
    cluster_ca_certificate = base64decode(module.base.aks_cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      # This requires the kubelogin to be installed locally where Terraform is executed
      args = ["get-token", "--server-id", module.base.aks_server_app_id, "--login", "azurecli"]
    }
  }
}
