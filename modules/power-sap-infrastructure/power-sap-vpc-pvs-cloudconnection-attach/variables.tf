variable "pvs_zone" {
  description = "IBM PowerVS Cloud Zone"
  type        = string
}

variable "pvs_resource_group_name" {
  description = "Existing Resource Group Name"
  type        = string
}

variable "pvs_service_name" {
  description = "Existing PowerVS Service Name"
  type        = string
}

variable "cloud_connection_count" {
  description = "Required number of Cloud connections. Ignore when Reusing. Maximum is 2 per location"
  type        = string
  default     = 2
}

variable "cloud_connection_speed" {
  description = "Speed in megabits per sec. Supported values are 50, 100, 200, 500, 1000, 2000, 5000, 10000. Required when creating new connection"
  type        = string
  default     = null
}

variable "pvs_subnet_names" {
  description = "List of PowerVs subnet names to be attached to Cloud connection"
  type        = list
}

variable "vpc_region" {
  description = "IBM Cloud VPC Region. Required if cloud_connection_vpc_enable is true"
  type        = string
  default     = null
}

variable "vpc_crns" {
  description = "Existing VPC Crns which has to be attached to Cloud connection"
  type        = list
  default     = []
}

variable "cloud_connection_gr" {
  description = "Enable global routing for this cloud connection.Can be specified when creating new connection"
  type        = bool
  default     = null
}

variable "cloud_connection_metered" {
  description = "Enable metered for this cloud connection. Can be specified when creating new connection"
  type        = bool
  default     = null
}

variable "ibmcloud_api_key" {
  description = "IBM Cloud Api Key"
  type        = string
  default     = null
}
