#####################################################
# PVS SAP Instance Deployment example for HANA
# Copyright 2022 IBM
#####################################################

provider "ibm" {
  region    =   var.pvs_region
  zone      =   var.pvs_zone
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

locals {
os_release_list = split("-",var.pvs_instance_image_name)
}


module "hana" {
  // source = "terraform-ibm-modules/powervs/ibm/modules/power-sap-instance"
  source = "../../modules/power-sap-instance"
  
  pvs_zone                       = var.pvs_zone
  pvs_resource_group_name        = var.pvs_resource_group_name
  brownfield                     = true
  pvs_service_name               = var.pvs_service_name
  pvs_instance_hostname          = var.pvs_instance_hostname
  pvs_sshkey_name                = var.pvs_sshkey_name
  pvs_instance_image_name        = var.pvs_instance_image_name
  pvs_instance_profile_id        = var.pvs_instance_profile_id
  pvs_instance_private_net_names = var.pvs_instance_private_net_names
  pvs_instance_storage_config    = var.pvs_instance_storage_config

  ####OS Initialization Variables

  bastion_public_ip              = var.bastion_public_ip
  bastion_private_ip             = var.bastion_private_ip
  proxy_config                   = var.proxy_config
  ssh_private_key                = var.ssh_private_key
  os_activation                  = merge(var.os_activation,{"os_release" = "${element(local.os_release_list, length(local.os_release_list) - 2)}.${element(local.os_release_list, length(local.os_release_list) - 1)}"})
  sap_solution                   = "HANA"
  sap_domain                     = var.sap_domain
}