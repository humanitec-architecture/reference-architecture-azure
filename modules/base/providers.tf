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
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.3.0"
}
