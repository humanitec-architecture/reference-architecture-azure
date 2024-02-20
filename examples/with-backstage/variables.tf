variable "subscription_id" {
  description = "Azure Subscription (ID) to use"
  type        = string
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "github_org_id" {
  description = "GitHub org id"
  type        = string
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID"
  type        = string
}

variable "humanitec_ci_service_user_token" {
  description = "Humanitec CI Service User Token"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "The Azure VM instances type to use as \"Agents\" (aka Kubernetes Nodes) in AKS"
  type        = string
  default     = "Standard_D2_v2"
}
