
variable "subscription_id" {
  description = "Azure Subscription (ID) to use"
  type        = string
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID"
  type        = string
}

variable "vm_size" {
  description = "List of EC2 instances types to use for EKS nodes"
  type        = string
  default     = "Standard_D2_v2"
}
