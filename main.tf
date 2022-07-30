#####################################################
# PVS Configuration
# Copyright 2022 IBM
#####################################################

provider "ibm" {
  region    =   lookup(var.ibm_pvs_zone_region_map,var.pvs_zone, null)
  zone      =   var.pvs_zone
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

module "pvs" {
  // source = "terraform-ibm-modules/powervs/ibm/modules/power-sap-infrastructure"
  source = "./modules/power-sap-infrastructure"

  pvs_zone                    = var.pvs_zone
  pvs_resource_group_name     = var.pvs_resource_group_name
  pvs_service_name            = "${var.prefix}-pvs"
  pvs_tags                    = var.pvs_tags
  pvs_sshkey_name             = "${var.prefix}-key"
  pvs_public_key              = var.pvs_public_key
  pvs_management_network      = var.pvs_management_network
  pvs_backup_network          = var.pvs_backup_network
  transit_gw_name             = var.transit_gw_name
  cloud_connection_reuse      = var.cloud_connection_reuse
  cloud_connection_count      = var.cloud_connection_count
  cloud_connection_speed      = var.cloud_connection_speed
  ibmcloud_api_key            = var.ibmcloud_api_key
  cloud_connection_gr         = var.cloud_connection_gr
  cloud_connection_metered    = var.cloud_connection_metered
}
