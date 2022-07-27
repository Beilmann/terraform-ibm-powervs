output "BASTION_PUBLIC_IP" {
  description = "Public IP of Provided Bastion/JumpServer Host"
  value       = module.hana.bastion_public_ip
}

output "PVS_HANA_IPS" {
  description = "All private IPS of HANA instance"
  value       = module.hana.pvs_instance_ips
}

output "PVS_NW_IPS" {
  description = "All private IPs of NW instances"
  value       = module.netweaver.*.pvs_instance_ips
}