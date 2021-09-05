variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  default     = "" # Fill your AWS Access Key
}

variable "aws_secret_key" {
  description = "AWS Secret Key" 
  type        = string
  default     = "" # Fill your AWS Secret Key
}

variable "az_count" {
  description = "number of active availability zones in VPC"
  default     = "3"
}

variable "vpc_cidr_base" {
  default = "172.31"
}

variable "demo_subnet_cidrs" {
  description = "CIDRs for the demo subnets"
  default = {
    zone0 = ".11.0/24"
    zone1 = ".12.0/24"
    zone2 = ".13.0/24"
  }
}

variable "aws_azs" {
  description = "comma separated string of availability zones in order of precedence"
  default     = "ap-southeast-1a, ap-southeast-1b, ap-southeast-1c"
}

variable "demo_subnet_name" {
  description = "comma separated string of availability zones in order of precedence"
  default     = "Subnet-Demo-1a, Subnet-Demo-1b, Subnet-Demo-1c"
}

variable "global_tags" {
  description = "AWS tags that will be added to all resources managed herein"
  type = map(string)
  default = {
    "ManagedBy" = "Terraform"
  }
}

variable "demo_subnet_tags" {
  description = "Tags to apply to the demo subnet"
  default     = {}
}

locals {
  environments = ["Subnet-Demo-1a", "Subnet-Demo-1b", "Subnet-Demo-1c"]
}

variable "dns_domain_name" {
  description = "Domain name of the DNS server"
}