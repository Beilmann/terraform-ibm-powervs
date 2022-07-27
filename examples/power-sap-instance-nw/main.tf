#####################################################
# PVS SAP Instance Deployment example For Netweaver
# Copyright 2022 IBM
#####################################################

provider "ibm" {
  region    =   lookup(var.ibm_pvs_zone_region_map,var.pvs_zone, null)
  zone      =   var.pvs_zone
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

module "netweaver" {
  // source = "terraform-ibm-modules/powervs/ibm/modules/power-sap-instance"
  source = "../../modules/power-sap-instance"
  
  pvs_zone                       = var.pvs_zone
  pvs_resource_group_name        = var.pvs_resource_group_name
  brownfield                     = true
  pvs_service_name               = var.pvs_service_name
  pvs_instance_hostname          = var.pvs_instance_hostname
  pvs_sshkey_name                = var.pvs_sshkey_name
  pvs_instance_image_name        = var.pvs_instance_image_name
  pvs_instance_sys_type          = var.pvs_instance_sys_type
  pvs_instance_proc_type         = var.pvs_instance_proc_type
  pvs_instance_processors        = var.pvs_instance_processors
  pvs_instance_memory            = var.pvs_instance_memory
  pvs_instance_private_net_names = var.pvs_instance_private_net_names
  pvs_instance_storage_config    = var.pvs_instance_storage_config

  ####OS Initialization Variables

  bastion_public_ip              = var.bastion_public_ip
  bastion_private_ip             = var.bastion_private_ip
  ssh_private_key                = var.ssh_private_key
  os_activation                  = var.os_activation
  sap_solution                   = "NETWEAVER"
  sap_domain                     = var.sap_domain
}