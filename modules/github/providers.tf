terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.87"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.38"
    }
  }
  required_version = ">= 1.3.0"
}
