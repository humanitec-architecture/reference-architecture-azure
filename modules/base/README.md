# base 

Module that provides the reference architecture.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.11 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.47 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.87 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12 |
| <a name="requirement_humanitec"></a> [humanitec](#requirement\_humanitec) | ~> 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.47 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.87 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12 |
| <a name="provider_humanitec"></a> [humanitec](#provider\_humanitec) | ~> 1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_aks"></a> [azure\_aks](#module\_azure\_aks) | Azure/aks/azurerm | ~> 7 |

## Resources

| Name | Type |
|------|------|
| [azuread_application.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_group.cluster_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.cluster_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_service_principal.humanitec](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.humanitec](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_public_ip.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.humanitec_cluster_admin_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.humanitec_cluster_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [humanitec_resource_definition.k8s_cluster_driver](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition_criteria.k8s_cluster_driver](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_service_principal.aks](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure region to deploy into | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure Subscription (ID) to use | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name for the AKS cluster | `string` | `"ref-arch"` | no |
| <a name="input_container_registry_name_prefix"></a> [container\_registry\_name\_prefix](#input\_container\_registry\_name\_prefix) | Name for Azure Container Registry | `string` | `"humrefarch"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment to be deployed into | `string` | `"development"` | no |
| <a name="input_ingress_nginx_min_unavailable"></a> [ingress\_nginx\_min\_unavailable](#input\_ingress\_nginx\_min\_unavailable) | Number of allowed unavaiable replicas for the ingress-nginx controller | `number` | `1` | no |
| <a name="input_ingress_nginx_replica_count"></a> [ingress\_nginx\_replica\_count](#input\_ingress\_nginx\_replica\_count) | Number of replicas for the ingress-nginx controller | `number` | `2` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to create | `string` | `"ref-arch"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The Azure VM instances type to use as "Agents" (aka Kubernetes Nodes) in AKS | `string` | `"Standard_D2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_cluster_ca_certificate"></a> [aks\_cluster\_ca\_certificate](#output\_aks\_cluster\_ca\_certificate) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_aks_host"></a> [aks\_host](#output\_aks\_host) | Endpoint for your Kubernetes API server |
| <a name="output_aks_oidc_issuer_url"></a> [aks\_oidc\_issuer\_url](#output\_aks\_oidc\_issuer\_url) | Issuer URL for the OpenID Connect discovery endpoint |
| <a name="output_aks_server_app_id"></a> [aks\_server\_app\_id](#output\_aks\_server\_app\_id) | Azure Kubernetes Service AAD Server |
| <a name="output_az_container_registry_id"></a> [az\_container\_registry\_id](#output\_az\_container\_registry\_id) | ID of the created azure container registry |
| <a name="output_az_container_registry_name"></a> [az\_container\_registry\_name](#output\_az\_container\_registry\_name) | Name of the created azure container registry |
| <a name="output_az_resource_group_location"></a> [az\_resource\_group\_location](#output\_az\_resource\_group\_location) | Location of the created azure resource group |
| <a name="output_az_resource_group_name"></a> [az\_resource\_group\_name](#output\_az\_resource\_group\_name) | Name of the created azure resource group |
| <a name="output_environment"></a> [environment](#output\_environment) | Name of the environment to be deployed into |
| <a name="output_ingress_nginx_external_ip"></a> [ingress\_nginx\_external\_ip](#output\_ingress\_nginx\_external\_ip) | External IP address for the Nginx ingress controller |
<!-- END_TF_DOCS -->
