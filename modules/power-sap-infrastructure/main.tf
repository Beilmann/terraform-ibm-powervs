#####################################################
# PVS Configuration
# Copyright 2022 IBM
#####################################################

module "sap-service" {
  source = "./power-sap-service"
  
  pvs_zone                  = var.pvs_zone
  pvs_resource_group_name   = var.pvs_resource_group_name
  pvs_service_name          = var.pvs_service_name 
  pvs_tags                  = var.pvs_tags
  pvs_sshkey_name           = var.pvs_sshkey_name
  pvs_public_key            = var.pvs_public_key
  pvs_management_network    = var.pvs_management_network
  pvs_backup_network        = var.pvs_backup_network
}

provider "ibm" {
  alias            = "dlcvpc"
  region           = var.vpc_region
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

module "cloud-connection" {
  source  = "./power-sap-vpc-pvs-cloudconnection-new"
  depends_on                  = [module.sap-service]
  count                       = !var.cloud_connection_reuse ? 1 : 0
  pvs_zone                    = var.pvs_zone
  pvs_resource_group_name     = var.pvs_resource_group_name
  pvs_service_name            = var.pvs_service_name
  transit_gw_name             = var.transit_gw_name
  cloud_connection_count      = var.cloud_connection_count
  cloud_connection_speed      = var.cloud_connection_speed
  cloud_connection_gr         = var.cloud_connection_gr
  cloud_connection_metered    = var.cloud_connection_metered

}

module "cloud-connection-attach" {
  source  = "./power-sap-vpc-pvs-cloudconnection-attach"
  depends_on                  = [module.cloud-connection]
  pvs_zone                    = var.pvs_zone   
  pvs_resource_group_name     = var.pvs_resource_group_name
  pvs_service_name            = var.pvs_service_name
  cloud_connection_count      = var.cloud_connection_count
  pvs_subnet_names            = [var.pvs_management_network.name,var.pvs_backup_network.name]
}
