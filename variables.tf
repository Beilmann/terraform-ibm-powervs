variable "pvs_zone" {
  description = "IBM Cloud PVS Zone. Valid values: sao01,osa21,tor01,us-south,dal12,us-east,tok04,lon04,lon06,eu-de-1,eu-de-2,syd04,syd05"
  type        = string
}

variable "pvs_resource_group_name" {
  description = "Existing Resource Group Name"
  type        = string
}

variable "prefix" {
  description = "Prefix for resources which will be created."
  type        = string
}

variable "pvs_public_key" {
  description = "PowerVS SSH Public key data"
  type        = string
}

variable "pvs_management_network" {
  description = "PowerVS Management Subnet name and cidr which will be created."
  type        = map
  default    = {
                 "name" = "mgmt_net"
                 "cidr" = "10.51.0.0/24"
               }
}

variable "pvs_backup_network" {
  description = "PowerVS Backup Network name and cidr which will be created."
  type        = map
  default    = {
                 "name" = "bkp_net"
                 "cidr" = "10.52.0.0/24"
               }
}

variable "cloud_connection_reuse" {
  description = "Use existing Cloud connection to attach PVS subnets"
  type        = bool
  default     = false
}

variable "transit_gw_name" {
  description = "Name of the existing transit gateway. Required only if new cloud connections are created."
  type        = string
}

#####################################################
# Optional Parameters
#####################################################

variable "cloud_connection_count" {
  description = "Required number of Cloud connections. Ignore when Reusing. Maximum is 2 per location"
  type        = string
  default     = "2"
}

variable "cloud_connection_speed" {
  description = "Speed in megabits per sec. Supported values are 50, 100, 200, 500, 1000, 2000, 5000, 10000. Required when creating new connection"
  type        = string
  default     = "5000"
}

variable "pvs_tags" {
  description = "List of Tag names for PowerVS service"
  type        = list(string)
  default     = null
}

variable "cloud_connection_gr" {
  description = "Enable global routing for this cloud connection.Can be specified when creating new connection"
  type        = bool
  default     = true
}

variable "cloud_connection_metered" {
  description = "Enable metered for this cloud connection. Can be specified when creating new connection"
  type        = bool
  default     = false
}

variable "ibmcloud_api_key" {
  description = "IBM Cloud Api Key"
  type        = string
  default     = null
}

variable "ibm_pvs_zone_region_map" {
  description = "Map of IBM Power VS zone to the region of PowerVS Infrastructure"
  type        = map
  default     = {    
                  "syd04"    = "syd"
                  "syd05"    = "syd" 
                  "eu-de-1"  = "eu-de"
                  "eu-de-2"  = "eu-de"
                  "lon04"    = "lon"
                  "lon06"    = "lon"
                  "tok04"    = "tok" 
                  "us-east"  = "us-east"
                  "us-south" = "us-south"
                  "dal12"    = "us-south"
                  "tor01"    = "tor"
                  "osa21"    = "osa"
                  "sao01"    = "sao"
        }
}
