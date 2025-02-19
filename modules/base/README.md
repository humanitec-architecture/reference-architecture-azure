# base 

Module that provides the reference architecture.

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azapi | ~> 1.11 |
| azuread | ~> 2.47 |
| azurerm | ~> 3.87 |
| helm | ~> 2.12 |
| humanitec | ~> 1.0 |
| random | ~> 3.5 |

### Providers

| Name | Version |
|------|---------|
| azuread | ~> 2.47 |
| azurerm | ~> 3.87 |
| helm | ~> 2.12 |
| humanitec | ~> 1.0 |
| random | ~> 3.5 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| azure\_aks | Azure/aks/azurerm | ~> 7 |
| default\_mysql | github.com/humanitec-architecture/resource-packs-in-cluster//humanitec-resource-defs/mysql/basic | v2024-11-05 |
| default\_postgres | github.com/humanitec-architecture/resource-packs-in-cluster//humanitec-resource-defs/postgres/basic | v2024-11-05 |

### Resources

| Name | Type |
|------|------|
| [azuread_application.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.credential](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_group.cluster_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.cluster_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_service_principal.humanitec](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_public_ip.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.humanitec_cluster_admin_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.humanitec_cluster_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [humanitec_resource_account.cluster_account](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_account) | resource |
| [humanitec_resource_definition.emptydir_volume](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.k8s_cluster_driver](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition_criteria.default_mysql](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.default_postgres](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.emptydir_volume](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_cluster_driver](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_service_principal.aks](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| humanitec\_org\_id | Humanitec Organization ID | `string` | n/a | yes |
| location | Azure region to deploy into | `string` | n/a | yes |
| subscription\_id | Azure Subscription (ID) to use | `string` | n/a | yes |
| cluster\_name | Name for the AKS cluster | `string` | `"ref-arch"` | no |
| container\_registry\_name\_prefix | Name for Azure Container Registry | `string` | `"humrefarch"` | no |
| environment | Name of the environment to be deployed into | `string` | `"development"` | no |
| ingress\_nginx\_min\_unavailable | Number of allowed unavaiable replicas for the ingress-nginx controller | `number` | `1` | no |
| ingress\_nginx\_replica\_count | Number of replicas for the ingress-nginx controller | `number` | `2` | no |
| resource\_group\_name | Name of the resource group to create | `string` | `"ref-arch"` | no |
| vm\_size | The Azure VM instances type to use as "Agents" (aka Kubernetes Nodes) in AKS | `string` | `"Standard_D2_v2"` | no |

### Outputs

| Name | Description |
|------|-------------|
| aks\_cluster\_ca\_certificate | Base64 encoded certificate data required to communicate with the cluster |
| aks\_host | Endpoint for your Kubernetes API server |
| aks\_oidc\_issuer\_url | Issuer URL for the OpenID Connect discovery endpoint |
| aks\_server\_app\_id | Azure Kubernetes Service AAD Server |
| az\_container\_registry\_id | ID of the created azure container registry |
| az\_container\_registry\_name | Name of the created azure container registry |
| az\_resource\_group\_location | Location of the created azure resource group |
| az\_resource\_group\_name | Name of the created azure resource group |
| environment | Name of the environment to be deployed into |
| ingress\_nginx\_external\_ip | External IP address for the Nginx ingress controller |
<!-- END_TF_DOCS -->
