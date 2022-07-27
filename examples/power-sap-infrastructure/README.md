# PowerVS SAP Infrastructure Module Example

This example creates:

- PVS service
- ssh key
- 2 private networks for management network and backup network
- Imports stock sap catalogue images.
- Creates 1 or 2 cloud connections and attaches VPC and PowerVS subnets
- Option to Reuse Cloud connection to attach new PowerVS subnets

This example illustrates how to use the `power-sap-infrastructure` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pvs"></a> [pvs](#module\_pvs) | ../../modules/power-sap-infrastructure | n/a |


## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| <a name="input_pvs_zone"></a> [pvs\_zone](#input\_pvs\_zone) | IBM PowerVS Cloud Zone. Valid values: sao01,osa21,tor01,us-south,dal12,us-east,tok04,lon04,lon06,eu-de-1,eu-de-2,syd04,syd05 | `string` | n/a | yes |
| <a name="input_pvs_resource_group_name"></a> [pvs\_resource\_group\_name](#input\_pvs\_resource\_group\_name) | Existing Resource Group Name | `string` | n/a | yes |
| <a name="prefix"></a> [prefix](#prefix) | Prefix for resources which will be created | `string` | n/a | yes |
| <a name="input_pvs_service_name"></a> [pvs\_service\_name](#input\_pvs\_service\_name) | Name of PowerVS service which will be created | `string` | n/a | yes |
| <a name="input_pvs_sshkey_name"></a> [pvs\_sshkey\_name](#input\_pvs\_sshkey\_name) | Name of PowerVS SSH Key which will be created | `string` | `power-service` | yes |
| <a name="input_pvs_public_key"></a> [pvs\_public\_key](#input\_pvs\_public\_key) | PowerVS SSH Public key data | `string` | `ssh-key-pvs` | yes |
| <a name="input_pvs_image_names"></a> [pvs\_image\_names](#input\_pvs\_image\_names) | List of Images to be imported into cloud account from catalog images | `list(string)` | <pre>[<br>  "Linux-SUSE-SAP-15-3",<br>  "Linux-RHEL-SAP-8-4"<br>]</pre> | optional |
| <a name="input_pvs_management_network"></a> [pvs\_management\_network](#input\_pvs\_management\_network) | PowerVS Management Subnet name and cidr which will be created. | `map` | <pre>{<br>"name" = "mgmt_net", <br>"cidr" = "10.51.0.0/24"<br>}</pre> | yes |
| <a name="input_pvs_backup_network"></a> [pvs\_backup\_network](#input\_pvs\_backup\_network) | PowerVS Backup Network name and cidr which will be created. | `map` | <pre>{<br>"name" = "bkp_net", <br>"cidr" = "10.52.0.0/24"<br>}</pre> | yes |
| <a name="input_cloud_connection_reuse"></a> [cloud\_connection\_reuse](#input\_cloud\_connection\_reuse) | Use existing Cloud connection to attach PVS subnets | `bool` | `false` | yes |
| <a name="input_cloud_connection_name"></a> [cloud\_connection\_name](#input\_cloud\_connection\_name) | Name of the Cloud connection which will be created/ Existing name of cloud connection to attach subnets | `string` | `false` | yes |
| <a name="input_cloud_connection_count"></a> [cloud\_connection\_count](#input\_cloud\_connection\_count) | Required number of Cloud connections. Ignore when Reusing. Maximum is 2 per location | `string` | `2` | optional |
| <a name="input_cloud_connection_speed"></a> [cloud\_connection\_speed](#input\_cloud\_connection\_speed) | Speed in megabits per sec. Supported values are 50, 100, 200, 500, 1000, 2000, 5000, 10000. Required when creating new connection | `string` | `5000` | optional |
| <a name="input_pvs_tags"></a> [pvs\_tags](#input\_pvs\_tags) | List of Tag names for PowerVS service | `list(string)` | `null` | optional |
| <a name="input_vpc_region"></a> [vpc\_region](#input\_vpc\_region) | IBM Cloud VPC Region.Required when creating new connection| `string` | `null` | optional |
| <a name="input_vpc_names"></a> [vpc\_names](#input\_vpc\_names) | Existing VPC Names which has to be attached to Cloud connection. Required when creating new connection. | `list` | `[]` | optional |
| <a name="input_cloud_connection_gr"></a> [cloud\_connection\_gr](#input\_cloud\_connection\_gr) | Enable global routing for this cloud connection.Can be specified when creating new connection | `bool` | `true` | optional |
| <a name="input_cloud_connection_metered"></a> [cloud\_connection\_metered](#input\_cloud\_connection\_metered) | Enable metered for this cloud connection. Can be specified when creating new connection | `bool` | `false` | optional |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud Api Key | `string` | `null` | optional |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure all details in input.tfvars

## Usage

terraform apply -var-file="input.tfvars"

## Note

For all optional fields, default values (Eg: `null`) are given in variable.tf file. User can configure the same by overwriting with appropriate values.
