variable "pvs_zone" {
  description = "IBM PowerVS Cloud Zone."
  type        = string
}

variable "pvs_resource_group_name" {
  description = "Existing Resource Group Name"
  type        = string
}

variable "pvs_service_name" {
  description = "Name of PowerVS service which will be created"
  type        = string
}

variable "pvs_sshkey_name" {
  description = "Name of PowerVS SSH Key which will be created"
  type        = string
}

variable "pvs_public_key" {
  description = "PowerVS SSH Public key data"
  type        = string
}

variable "pvs_management_network" {
  description = "PowerVS Management Subnet name and cidr which will be created."
  type        = map
}

variable "pvs_backup_network" {
  description = "PowerVS Backup Network name and cidr which will be created."
  type        = map
}

#####################################################
# Optional Parameters
#####################################################

variable "pvs_tags" {
  description = "List of Tag names for PowerVS service"
  type        = list(string)
  default     = null
}
