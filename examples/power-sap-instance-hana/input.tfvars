#####################################################
# Powervs instance module Example For HANA : RHEL/SLES
# Copyright 2022 IBM
#####################################################


/****************************************************
Example Usage:

ibmcloud_api_key               = "_3R"
pvs_zone                       = "sao01"
pvs_resource_group_name        = "Default"
pvs_service_name               = "TestService"
pvs_instance_hostname          = "hana-power"
pvs_sshkey_name                = "publish"
pvs_instance_image_name        = "Linux-SUSE-SAP-15-3"
pvs_instance_profile_id        = "ush1-4x128"
pvs_instance_private_net_names = [ "mgmt_net","bkp_net"]
pvs_instance_storage_config    = { 
                                   names      = "data,log,shared,usrsap"
                                   disks_size =  "180,200,300,50"
                                   counts     = "8,8,1,1"
                                   tiers      = "tier1,tier1,tier3,tier3"
                                   paths      = "/hana/data,/hana/log,/hana/shared,/usr/sap"
                                  }

bastion_public_ip              = "13.116.82.65"
bastion_private_ip             = "172.20.0.4"
os_activation                  = {
                                  required         = true
                                  activation_username = "<email>"
                                  activation_password  = "<activation code/password>"
                                 }
sap_domain                     = "" # required for RHEL image only
SSH_PRIVATE_KEY                = <<-EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3Blsadsadsi5fjoepepe
-----END OPENSSH PRIVATE KEY-----
EOF

******************************************************/