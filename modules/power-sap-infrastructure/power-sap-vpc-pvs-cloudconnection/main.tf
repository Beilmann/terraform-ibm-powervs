#####################################################
# PowerVs cloud connection Configuration
# Copyright 2022 IBM
#####################################################

locals {
  service_type          = "power-iaas"
}

data "ibm_resource_group" "resource_group_ds" {
  name = var.pvs_resource_group_name
}

data "ibm_resource_instance" "pvs_service_ds" {
  name                 = var.pvs_service_name
  service              = local.service_type
  location             = var.pvs_zone
  resource_group_id    = data.ibm_resource_group.resource_group_ds.id
}

/*
#####################################################
# Get VPC CRNS
# Copyright 2022 IBM
#####################################################


provider "ibm" {
  alias            = "dlcvpc"
  region           = var.vpc_region
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

data "ibm_is_vpc" "vpc_crn_ds" {
  count    = var.cloud_connection_vpc_enable ? length(var.vpc_names) : 0
  provider = ibm.dlcvpc 
  name     = var.vpc_names[count.index]
}
*/
#####################################################
# Get PowerVS subnet IDs
# Copyright 2022 IBM
#####################################################

data "ibm_pi_network" "pvs_subnets_ds" {
  count                = length(var.pvs_subnet_names)
  pi_cloud_instance_id = data.ibm_resource_instance.pvs_service_ds.guid
  pi_network_name      = var.pvs_subnet_names[count.index]
}

#####################################################
# Reuse Cloud Connection to attach PVS subnets
# Copyright 2022 IBM
#####################################################

data "ibm_pi_cloud_connections" "orig_cloud_connection_ds" {
  #count                     = var.cloud_connection_reuse ? 1 : 0
  pi_cloud_instance_id      = data.ibm_resource_instance.pvs_service_ds.guid
}

resource "ibm_pi_cloud_connection" "cloud_connection" {
  count                               = length(data.ibm_pi_cloud_connection.orig_cloud_connection_ds) < 1 ? 1 : 0 
  pi_cloud_instance_id                = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_name            = "${var.pvs_zone}-conn-1"
  pi_cloud_connection_speed           = var.cloud_connection_speed
  pi_cloud_connection_global_routing  = var.cloud_connection_gr
  pi_cloud_connection_metered         = var.cloud_connection_metered
  #pi_cloud_connection_networks        = toset(data.ibm_pi_network.pvs_subnets_ds.*.id)
  pi_cloud_connection_vpc_enabled     = length(var.vpc_crns) >= 1 ? true : null
  pi_cloud_connection_vpc_crns        = length(var.vpc_crns) >= 1 ? toset(var.vpc_crns) : null
}

resource "ibm_pi_cloud_connection" "cloud_connection_backup" {
  depends_on                          = [ibm_pi_cloud_connection.cloud_connection]
  count                               = length(data.ibm_pi_cloud_connection.orig_cloud_connection_ds) < 2 ? 1 : 0
  pi_cloud_instance_id                = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_name            = "${var.pvs_zone}-conn-2"
  pi_cloud_connection_speed           = var.cloud_connection_speed
  pi_cloud_connection_global_routing  = var.cloud_connection_gr
  pi_cloud_connection_metered         = var.cloud_connection_metered
  #pi_cloud_connection_networks        = toset(data.ibm_pi_network.pvs_subnets_ds.*.id)
  pi_cloud_connection_vpc_enabled     = length(var.vpc_crns) >= 1 ? true : null
  pi_cloud_connection_vpc_crns        = length(var.vpc_crns) >= 1 ? toset(var.vpc_crns) : null
}


data "ibm_pi_cloud_connections" "cloud_connection_ds" {
  #count                     = var.cloud_connection_reuse ? 1 : 0
  pi_cloud_instance_id      = data.ibm_resource_instance.pvs_service_ds.guid
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach" {
  count                  = length(data.ibm_pi_cloud_connection.cloud_connection_ds) > 0 ? 1 : 0
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connection.cloud_connection_ds.0.id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[0].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach2" {
  count                  = length(data.ibm_pi_cloud_connection.cloud_connection_ds) > 0 ? 1 : 0
  depends_on             = [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach]
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connection.cloud_connection_ds.0.id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[1].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach" {
  count                  = length(data.ibm_pi_cloud_connection.cloud_connection_ds) > 1 ? 1 : 0
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connection.cloud_connection_ds.1.id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[0].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach2" {
  count                  = length(data.ibm_pi_cloud_connection.cloud_connection_ds) > 1 ? 1 : 0
  depends_on             = [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach]
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connection.cloud_connection_ds.1.id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[1].id
}
