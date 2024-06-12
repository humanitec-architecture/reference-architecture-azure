variable "subscription_id" {
  description = "Azure Subscription (ID) to use"
  type        = string
}

variable "az_resource_group_location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "az_resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "az_container_registry_id" {
  description = "ID of the created azure container registry"
  type        = string
}

variable "az_container_registry_name" {
  description = "Name of the created azure container registry"
  type        = string
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID"
  type        = string

  validation {
    condition     = var.humanitec_org_id != null
    error_message = "Humanitec Organization ID must not be empty"
  }
}

variable "humanitec_ci_service_user_token" {
  description = "Humanitec CI Service User Token"
  type        = string
  sensitive   = true

  validation {
    condition     = var.humanitec_ci_service_user_token != null
    error_message = "Humanitec CI Service User Token must not be empty"
  }
}

variable "github_org_id" {
  description = "GitHub org id"
  type        = string

  validation {
    condition     = var.github_org_id != null
    error_message = "GitHub org id must not be empty"
  }
}
