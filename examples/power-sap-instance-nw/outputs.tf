output "BASTION_PUBLIC_IP" {
  description = "Public IP of Provided Bastion/JumpServer Host"
  value      = module.netweaver.bastion_public_ip
}

output "PVS_NW_IPS" {
  description = "All private IPS of NetWeaver instance"
  value      = module.netweaver.pvs_instance_ips
}
