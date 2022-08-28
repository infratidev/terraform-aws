#####################################################
# VPC Requirement
#####################################################

variable "custom_vpc" {
  description = "VPC for testing environment"
  type        = string
  default     = "10.0.0.0/16"
}

#####################################################
# EC2 Requirement
#####################################################

variable "instance_tenancy" {
  description = "it defines the tenancy of VPC. Whether it's defsult or dedicated"
  type        = string
  default     = "default"
}

variable "instance_type" {
  description = "Instance type to create an instance"
  type        = string
  default     = "t2.micro"
}

variable "ssh_private_key" {
  description = "pem file of Keypair we used to login to EC2 instances"
  type        = string
  default     = "../keypair/XXXXXXX.pem"
}

variable "ssh_userdata" {
  description = "Ssh userdata.sh file"
  type        = string
  default     = "userdata.sh"
}

variable "ssh_path_userdata" {
  description = "Path home userdata.sh"
  type        = string
  default     = "/home/admin/userdata.sh"
}

variable "region" {
    description = "Default region"
    default = "us-east-1"
}

variable "bastion_instances_count" {
    description = "Instances Bastion number"
    default     = 1
    type        = number
}


#####################################################
# Public subnet CIDR Bastion
#####################################################

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.20.0/24","10.0.21.0/24"]
}

#####################################################
# Private subnet CIDR
#####################################################

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.50.0/24","10.0.51.0/24"]
}
