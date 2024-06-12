variable "subscription_id" {
  description = "Azure Subscription (ID) to use"
  type        = string
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "vm_size" {
  description = "The Azure VM instances type to use as \"Agents\" (aka Kubernetes Nodes) in AKS"
  type        = string
  default     = "Standard_D2_v2"
}

variable "with_backstage" {
  description = "Deploy Backstage"
  type        = bool
  default     = false
}

variable "github_org_id" {
  description = "GitHub org id (required for Backstage)"
  type        = string
  default     = null
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID (required for Backstage)"
  type        = string
  default     = null
}
