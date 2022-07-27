# PowerVS SAP SYSTEM

It creates empty SAP SYSTEM landscape: 
- 1 SAP network and attaches it to Cloud connection
- 1 HANA instance on e980 PowerVS with specified volumes
- N number of NetWeaver instances on s922 PowerVS 

Note: prerequisite The bastion host must be running SQUID proxy server with 3128 port open. If squid server is not on bastion host, then pass the squid server public and private ips to variables `input_bastion_public_ip` and `input_bastion_private_ip`

This example illustrates how to use the `power-sap-instance` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hana"></a> [hana](#module\_hana) | ../../modules/power-sap-instance | n/a |
| <a name="module_netweaver"></a> [netweaver](#module\_netweaver) | ../../modules/power-sap-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection_network_attach) | resource |
| [ibm_pi_network.sap_network](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_network) | resource |
| [ibm_pi_cloud_connection.cloud_connection_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_cloud_connection) | data source |
| [ibm_resource_group.resource_group_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_group) | data source |
| [ibm_resource_instance.pvs_service_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_instance) | data source |

## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| <a name="input_pvs_zone"></a> [pvs\_zone](#input\_pvs\_zone) | IBM Cloud PVS Zone. Valid values: sao01,osa21,tor01,us-south,dal12,us-east,tok04,lon04,lon06,eu-de-1, eu-de-2,syd04,syd05 | `string` | n/a | yes |
| <a name="input_pvs_resource_group_name"></a> [pvs\_resource\_group\_name](#input\_pvs\_resource\_group\_name) | Existing PowerVS service resource group Name | `string` | n/a | yes |
| <a name="input_pvs_service_name"></a> [pvs\_service\_name](#input\_pvs\_service\_name) | Existing Name of the PowerVS service | `string` | n/a | yes |
| <a name="input_pvs_sshkey_name"></a> [pvs\_sshkey\_name](#input\_pvs\_sshkey\_name) | Existing SSH key name | `string` | n/a | yes |
| <a name="input_pvs_instance_image_name"></a> [pvs\_instance\_image\_name](#input\_pvs\_instance\_image\_name) | Image Name for node | `string` | `"Linux-SUSE-SAP-15-3"` | yes |
| <a name="input_pvs_instance_private_net_names"></a> [pvs\_instance\_private\_net\_names](#input\_pvs\_instance\_private\_net\_names) | Existing list of subnets name to be attached to node. First network has to be a management network | `list` | n/a | yes |
| <a name="input_pvs_instance_sap_network"></a> [pvs\_instance\_sap\_network](#input\_pvs\_instance\_sap\_network) | New Network for SAP system | `map` | <pre>{<br>  "cidr": "10.111.1.1/24",<br>  "name": "sap_net"<br>}</pre> | no |
| <a name="input_cloud_connection_name"></a> [cloud\_connection\_name](#input\_cloud\_connection\_name) | Existing cloud connection name, to attach the new sap network | `string` | n/a | yes |
| <a name="input_pvs_hana_instance_hostname"></a> [pvs\_hana\_instance\_hostname](#input\_pvs\_hana\_instance\_hostname) | Name of hana instance which will be created | `string` | n/a | yes |
| <a name="input_pvs_hana_instance_profile_id"></a> [pvs\_hana\_instance\_profile\_id](#input\_pvs\_hana\_instance\_profile\_id) | SAP PROFILE ID for hana instance. If this is mentioned then Memory, processors, proc\_type and sys\_type will not be taken into account | `string` | `"ush1-4x128"` | yes |
| <a name="input_pvs_hana_instance_storage_config"></a> [pvs\_hana\_instance\_storage\_config](#input\_pvs\_hana\_instance\_storage\_config) | DISKS To be created and attached to hana node.Comma separated values | `map` | {<br>  "counts": "8,8,1,1"<br>  "disks_size": "180,200,300,50"<br>  "names": "data,log,shared,usrsap"<br>  "paths": "/hana/data,/hana/log,/hana/shared,/usr/sap"<br>  "tiers": "tier1,tier1,tier3,tier3"<br>} | optional |
| <a name="input_pvs_nw_instance_hostname"></a> [pvs\_nw\_instance\_hostname](#input\_pvs\_nw\_instance\_hostname) | Name of nw instances which will be created | `string` | `"nw"` | yes |
| <a name="input_pvs_nw_instance_count"></a> [pvs\_nw\_instance\_count](#input\_pvs\_nw\_instance\_count) | Number of NetWeaver instances to be created | `number` | `2` | yes |
| <a name="input_pvs_nw_instance_proc_type"></a> [pvs\_nw\_instance\_proc\_type](#input\_pvs\_nw\_instance\_proc\_type) | Dedicated or shared or uncapped processors | `string` | `"dedicated"` | yes |
| <a name="input_pvs_nw_instance_processors"></a> [pvs\_nw\_instance\_processors](#input\_pvs\_nw\_instance\_processors) | Number of processors | `string` | `"4"` | yes |
| <a name="input_pvs_nw_instance_memory"></a> [pvs\_nw\_instance\_memory](#input\_pvs\_nw\_instance\_memory) | Amount of memory | `string` | `"400"` | yes |
| <a name="input_pvs_nw_instance_storage_config"></a> [pvs\_nw\_instance\_storage\_config](#input\_pvs\_nw\_instance\_storage\_config) | DISKS To be created and attached to nw nodes.Comma separated values | `map` | <pre>{<br>  "counts": "1,1",<br>  "disks_size": "50,60",<br>  "names": "usrsap,usrtrans",<br>  "paths": "/usr/sap,/usr/sap/trans",<br>  "tiers": "tier3,tier3"<br>}</pre> | optional |
| <a name="input_bastion_public_ip"></a> [bastion\_public\_ip](#input\_bastion\_public\_ip) | Existing Public IP of Bastion/jumpserver Host. Squid must be running on this host | `string` | n/a | yes |
| <a name="input_bastion_private_ip"></a> [bastion\_private\_ip](#input\_bastion\_private\_ip) | Existing Private IP of Bastion/jumpserver Host. Squid must be running on this host | `string` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | Private Key to configure Instance, Will not be uploaded to server | `string` | n/a | yes |
| <a name="input_os_activation"></a> [os\_activation](#input\_os\_activation) | SUSE/RHEL activation username and password to register OS | `map` | <pre>{<br>  "activation_password": "",<br>  "activation_username": "",<br>  "required": false<br>}</pre> | optional |
| <a name="input_sap_domain"></a> [sap\_domain](#input\_sap\_domain) | Domain name to be set. Required when deploying RHEL system. | `string` | n/a | optional |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud Api Key | `string` | `null` | optional |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_BASTION_PUBLIC_IP"></a> [BASTION\_PUBLIC\_IP](#output\_BASTION\_PUBLIC\_IP) | Public IP of Provided Bastion/JumpServer Host |
| <a name="output_PVS_HANA_IPS"></a> [PVS\_HANA\_IPS](#output\_PVS\_HANA\_IPS) | All private IPS of HANA instance |
| <a name="output_PVS_NW_IPS"></a> [PVS\_NW\_IPS](#output\_PVS\_NW\_IPS) | All private IPs of NW instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

NOTE: We can configure all details in input.tfvars

## Usage

terraform apply -var-file="input.tfvars"

## Note

For all optional fields, default values (Eg: `null`) are given in variable.tf file. User can configure the same by overwriting with appropriate values.
