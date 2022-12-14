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

data "ibm_pi_cloud_connections" "cloud_connection_ds" {
  pi_cloud_instance_id      = data.ibm_resource_instance.pvs_service_ds.guid
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach" {
  depends_on             = [data.ibm_pi_network.pvs_subnets_ds[0]]
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connections.cloud_connection_ds.connections[0].cloud_connection_id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[0].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach2" {
  depends_on             = [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach, data.ibm_pi_network.pvs_subnets_ds[1]]
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connections.cloud_connection_ds.connections[0].cloud_connection_id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[1].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach3" {
  depends_on             = [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach2]
  count                  = var.cloud_connection_count > 1 ? 1 : 0
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connections.cloud_connection_ds.connections[1].cloud_connection_id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[0].id
}

resource "ibm_pi_cloud_connection_network_attach" "pvs_subnet_attach4" {
  count                  = var.cloud_connection_count > 1 ? 1 : 0
  depends_on             = [ibm_pi_cloud_connection_network_attach.pvs_subnet_attach3]
  pi_cloud_instance_id   = data.ibm_resource_instance.pvs_service_ds.guid
  pi_cloud_connection_id = data.ibm_pi_cloud_connections.cloud_connection_ds.connections[1].cloud_connection_id
  pi_network_id          = data.ibm_pi_network.pvs_subnets_ds[1].id
}
