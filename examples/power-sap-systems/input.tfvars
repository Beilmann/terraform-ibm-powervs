#####################################################
# Powervs instance module Example For SAP system
# Copyright 2022 IBM
#####################################################


/****************************************************
Example Usage :

ibmcloud_api_key                  = "_3R"
pvs_zone                          = "sao01"
pvs_resource_group_name           = "Default"
pvs_service_name                  = "TestService"
pvs_sshkey_name                   = "publish"
pvs_instance_image_name           = "Linux-SUSE-SAP-15-3"
pvs_instance_private_net_names    = [ "mgmt_net","bkp_net"]
pvs_instance_sap_network          = { 
                                     "name" = "sap_net"
								     "cidr" = "10.111.1.1/24"
								    }
cloud_connection_name             = "test2-auto"

pvs_hana_instance_hostname        = "hana"
pvs_hana_instance_profile_id      = "ush1-4x128"
pvs_hana_instance_storage_config  = { 
                                     names      = "data,log,shared,usrsap"
                                     disks_size = "160,150,300,50"
                                     counts     = "8,8,1,1"
								     tiers      = "tier1,tier1,tier3,tier3"
                                     paths      = "/hana/data,/hana/log,/hana/shared,/usr/sap"
                                    }
									
pvs_nw_instance_hostname          = "test"
pvs_nw_instance_count             = 3
pvs_nw_instance_proc_type         = "dedicated"
pvs_nw_instance_processors        = "2"
pvs_nw_instance_memory            = "100"								 
pvs_nw_instance_storage_config    = { 
                                     names      = "usrsap,usrtrans"
                                     disks_size = "50,60"
                                     counts     = "1,1"
                                     tiers      = "tier3,tier3"
                                     paths      = "/usr/sap,/usr/sap/trans"
                                    }

bastion_public_ip                 = "13.116.82.65"
bastion_private_ip                = "172.20.0.4"
os_activation                     = {
                                      required            = true
                                      activation_username = "<email>"
                                      activation_code     = "<activation code>"
                                    }
sap_domain                        = "" # required for RHEL image only
SSH_PRIVATE_KEY                   = <<-EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3Blsadsadsi5fjoepepe
-----END OPENSSH PRIVATE KEY-----
EOF

******************************************************/
