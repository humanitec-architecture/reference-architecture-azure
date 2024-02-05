variable "environment" {
  description = "Name of the environment to be deployed into"
  type        = string
  default     = "development"
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
  default     = "ref-arch"
}

variable "cluster_name" {
  description = "Name for the AKS cluster"
  type        = string
  default     = "ref-arch"
}

variable "vm_size" {
  description = "The Azure VM instances type to use as \"Agents\" (aka Kubernetes Nodes) in AKS"
  type        = string
  default     = "Standard_D2_v2"
}

variable "ingress_nginx_replica_count" {
  description = "Number of replicas for the ingress-nginx controller"
  type        = number
  default     = 2
}

variable "ingress_nginx_min_unavailable" {
  description = "Number of allowed unavaiable replicas for the ingress-nginx controller"
  type        = number
  default     = 1
}

variable "subscription_id" {
  description = "Azure Subscription (ID) to use"
  type        = string
}
