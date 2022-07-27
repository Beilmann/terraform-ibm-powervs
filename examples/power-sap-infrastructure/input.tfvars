#####################################################
# Powervs Infrastructure SAP module Example
# Copyright 2022 IBM
#####################################################

/****************************************************
Example 1 usage with new cloud connection:

ibmcloud_api_key        = "_3asd"
pvs_zone                = "sao01"
pvs_resource_group_name = "Default"
prefix                  = "test"
pvs_service_name        = "TestService"
pvs_sshkey_name         = "publish"
pvs_public_key          = "ssh-rsa AAAAB3Nz......"
pvs_image_names         = ["Linux-SUSE-SAP-12-4","Linux-RHEL-SAP-8-1"]
pvs_management_network  = {
  name = "mgmt_net"
  cidr = "10.51.0.0/24"
}
pvs_backup_network      = {
  name = "bkp_net"
  cidr = "10.52.0.0/24"
}
pvs_tags     = ["T1","T2"]
cloud_connection_reuse      = false
cloud_connection_count      = "1" ### 1 or 2 depending on availability in DC. Per DC max count is 2
cloud_connection_name       = "test2-auto"
cloud_connection_speed      = "5000"  ### mandatory
vpc_region                  = "br-sao" # mandatory
vpc_names                   = ["test-automation-sao2"] # mandatory
cloud_connection_gr         = true # optional
cloud_connection_metered    = false # optional

******************************************************/

/****************************************************
Example 2 usage reusing cloud connection:

ibmcloud_api_key        = "_3asd"
pvs_zone                = "sao01"
pvs_resource_group_name = "Default"
prefix                  = "test"
pvs_service_name        = "TestService"
pvs_sshkey_name         = "publish"
pvs_public_key          = "ssh-rsa AAAAB3Nz......"
pvs_image_names         = ["Linux-SUSE-SAP-12-4","Linux-RHEL-SAP-8-1"]
pvs_management_network  = {
  name = "mgmt_net"
  cidr = "10.51.0.0/24"
}
pvs_backup_network      = {
  name = "bkp_net"
  cidr = "10.52.0.0/24"
}
pvs_tags     = ["T1","T2"]
cloud_connection_reuse      = true
cloud_connection_name       = "test2-auto"
******************************************************/
