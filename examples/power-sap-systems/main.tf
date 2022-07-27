#####################################################
# PVS SAP Instance Deployment example for SAP SYSTEM with new private network
# Copyright 2022 IBM
#####################################################

provider "ibm" {
  region    =   lookup(var.ibm_pvs_zone_region_map,var.pvs_zone, null)
  zone      =   var.pvs_zone
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

data "ibm_resource_group" "resource_group_ds" {
  name = var.pvs_resource_group_name
}

data "ibm_resource_instance" "pvs_service_ds" {
  name                 = var.pvs_service_name
  service              = "power-iaas"
  location             = var.pvs_zone
  resource_group_id    = data.ibm_resource_group.resource_group_ds.id
}

resource "ibm_pi_network" "sap_network" {
  pi_cloud_instance_id = data.ibm_resource_instance.pvs_service_ds.guid
  pi_network_name      = var.pvs_instance_sap_network["name"]
  pi_cidr              = var.pvs_instance_sap_network["cidr"]
  pi_dns               = ["127.0.0.1"]
  pi_network_type      = "vlan"
  pi_network_jumbo     = true
}

data "ibm_pi_cloud_connection" "cloud_connection_ds" {
  pi_cloud_instance_id      = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_name  = var.cloud_connection_name
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach" {
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connection.cloud_connection_ds.id
  pi_network_id          = ibm_pi_network.sap_network.network_id
}

module "hana" {
  // source = "terraform-ibm-modules/powervs/ibm/modules/power-sap-instance"
  source = "../../modules/power-sap-instance"
  
  pvs_zone                       = var.pvs_zone
  pvs_resource_group_name        = var.pvs_resource_group_name
  brownfield                     = true
  pvs_service_name               = var.pvs_service_name
  pvs_instance_hostname          = var.pvs_hana_instance_hostname
  pvs_sshkey_name                = var.pvs_sshkey_name
  pvs_instance_image_name        = var.pvs_instance_image_name
  pvs_instance_profile_id        = var.pvs_hana_instance_profile_id
  pvs_instance_private_net_names = var.pvs_instance_private_net_names
  pvs_instance_private_net_ids   = [ibm_pi_network.sap_network.network_id]
  pvs_instance_storage_config    = var.pvs_hana_instance_storage_config

  ####OS Initialization Variables

  bastion_public_ip              = var.bastion_public_ip
  bastion_private_ip             = var.bastion_private_ip
  ssh_private_key                = var.ssh_private_key
  os_activation                  = var.os_activation
  sap_solution                   = "HANA"
  sap_domain                     = var.sap_domain
}

module "netweaver" {
  // source = "terraform-ibm-modules/powervs/ibm/modules/power-sap-instance"
  source = "../../modules/power-sap-instance"
  
  count                          = var.pvs_nw_instance_count
  
  pvs_zone                       = var.pvs_zone
  pvs_resource_group_name        = var.pvs_resource_group_name
  brownfield                     = true
  pvs_service_name               = var.pvs_service_name
  pvs_instance_hostname          = "${var.pvs_nw_instance_hostname}-${count.index + 1}"
  pvs_sshkey_name                = var.pvs_sshkey_name
  pvs_instance_image_name        = var.pvs_instance_image_name
  pvs_instance_sys_type          = "s922"
  pvs_instance_proc_type         = var.pvs_nw_instance_proc_type
  pvs_instance_processors        = var.pvs_nw_instance_processors
  pvs_instance_memory            = var.pvs_nw_instance_memory
  pvs_instance_private_net_names = var.pvs_instance_private_net_names
  pvs_instance_private_net_ids   = [ibm_pi_network.sap_network.network_id]
  pvs_instance_storage_config    = var.pvs_nw_instance_storage_config
  
  ####OS Initialization Variables

  bastion_public_ip              = var.bastion_public_ip
  bastion_private_ip             = var.bastion_private_ip
  ssh_private_key                = var.ssh_private_key
  os_activation                  = var.os_activation
  sap_solution                   = "NETWEAVER"
  sap_domain                     = var.sap_domain
}