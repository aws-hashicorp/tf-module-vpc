# GLOBALS
variable "availability_zones" {
  description = "List of availability zones for the private subnet."
  type        = list(string)
  default     = [""]
}

# VPC VARIABLES
variable "create_vpc" {
  description = "Flag to create a VPC."
  type        = bool
  default     = true
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the VPC."
  type        = string
  default     = "my-vpc"
}

# PRIVATE SUBNET VARIABLES
variable "create_private_subnet" {
  description = "Flag to create a private subnet."
  type        = bool
  default     = true
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet."
  type        = list(string)
  default     = [""]
}


# DATABASE SUBNET VARIABLES
variable "create_database_subnet" {
  description = "Flag to create a database subnet."
  type        = bool
  default     = true
}

variable "database_subnet_cidr_block" {
  description = "The CIDR block for the database subnet."
  type        = list(string)
  default     = [""]
}

# TRANSIT GATEWAY VARIABLES
variable "create_transit_gateway_attachment" {
  description = "Flag to create a transit gateway attachment."
  type        = bool
  default     = true
}

variable "transit_gateway_id" {
  description = "The ID of the transit gateway."
  type        = string
  default     = ""
}
