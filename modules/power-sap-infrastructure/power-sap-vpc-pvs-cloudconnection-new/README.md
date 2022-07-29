# Module power-sap-vpc-pvs-cloudconnection

This module is used to create/reuse a Cloud Connection

## Example Usage
```
provider "ibm" {
  region           =   "sao"
  zone             =   "sao01"
  ibmcloud_api_key = "your api key" != null ? "your api key" : null
}

module "cloud-connection" {

  pvs_zone                    = var.pvs_zone   
  pvs_resource_group_name     = var.pvs_resource_group_name
  pvs_service_name            = var.pvs_service_name
  cloud_connection_reuse      = var.cloud_connection_reuse
  cloud_connection_name       = var.cloud_connection_name
  cloud_connection_count      = var.cloud_connection_count
  cloud_connection_speed      = var.cloud_connection_speed
  pvs_subnet_names            = var.pvs_subnet_names
  ibmcloud_api_key            = var.ibmcloud_api_key
  vpc_region                  = var.vpc_region
  vpc_crns                    = var.vpc_crns
  cloud_connection_gr         = var.cloud_connection_gr
  cloud_connection_metered    = var.cloud_connection_metered
  
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Resources

| Name | Type |
|------|------|
| [ibm_pi_cloud_connection.cloud_connection](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection) | resource |
| [ibm_pi_cloud_connection.cloud_connection_backup](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection) | resource |
| [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection_network_attach) | resource |
| [ibm_pi_cloud_connection.cloud_connection_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_cloud_connection) | data source |
| [ibm_pi_network.pvs_subnets_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_network) | data source |
| [ibm_resource_group.resource_group_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_group) | data source |
| [ibm_resource_instance.pvs_service_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_instance) | data source |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pvs_zone"></a> [pvs\_zone](#input\_pvs\_zone) | IBM Cloud Zone | `string` | n/a | yes |
| <a name="input_pvs_resource_group_name"></a> [pvs\_resource\_group\_name](#input\_pvs\_resource\_group\_name) | Existing Resource Group Name | `string` | n/a | yes |
| <a name="input_pvs_service_name"></a> [pvs\_service\_name](#input\_pvs\_service\_name) | Existing PowerVS Service Name | `string` | n/a | yes |
| <a name="input_cloud_connection_reuse"></a> [cloud\_connection\_reuse](#input\_cloud\_connection\_reuse) | Use existing Cloud connection to attach PVS subnets | `bool` | n/a | yes |
| <a name="input_cloud_connection_name"></a> [cloud\_connection\_name](#input\_cloud\_connection\_name) | Name of the Cloud connection which will be created/ Existing name of cloud connection to attach subnets | `string` | n/a | yes |
| <a name="input_cloud_connection_count"></a> [cloud\_connection\_count](#input\_cloud\_connection\_count) | Required number of Cloud connections. Ignore when Reusing. Maximum is 2 per location | `string` | `2` | optional |
| <a name="input_cloud_connection_speed"></a> [cloud\_connection\_speed](#input\_cloud\_connection\_speed) | Speed in megabits per sec. Supported values are 50, 100, 200, 500, 1000, 2000, 5000, 10000. Required when creating new connection | `string` | `null` | yes |
| <a name="input_pvs_subnet_names"></a> [pvs\_subnet\_names](#input\_pvs\_subnet\_names) | List of PowerVs subnet names to be attached to Cloud connection | `list` | n/a | yes |
| <a name="input_vpc_region"></a> [vpc\_region](#input\_vpc\_region) | IBM Cloud VPC Region.| `string` | `null` | optional |
| <a name="input_vpc_crns"></a> [vpc\_crns](#input\_vpc\_crns) | Existing VPC Crns which has to be attached to Cloud connection. | `list` | `[]` | optional |
| <a name="input_cloud_connection_gr"></a> [cloud\_connection\_gr](#input\_cloud\_connection\_gr) | Enable global routing for this cloud connection.Can be specified when creating new connection | `bool` | `null` | optional |
| <a name="input_cloud_connection_metered"></a> [cloud\_connection\_metered](#input\_cloud\_connection\_metered) | Enable metered for this cloud connection. Can be specified when creating new connection | `bool` | `null` | optional |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud Api Key | `string` | `null` | optional |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
