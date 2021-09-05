variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  default     = ""  # Fill your AWS Access Key
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  default     = ""  # Fill your AWS Secret Key
} 

#################################
variable ecs_service_name {
  description="ECS Service Name"
  default=""
}

variable ecs_cluster_name {
  description="ECS Cluster Name"
  default=""
}

variable ecs_taskdef_name {
  description="ECS TaskDefinition Name"
  default=""
}

variable docker_container_port {
  description="Docker Container Port"
  default=""
}

variable src_ecr_repo_account { }
variable src_ecr_region {}

variable docker_image {
  default=""
  description="Docker image name"
}

variable container_name {}

variable docker_container_health_port {
  default=""
  description="Container health port"
}

variable host_port {
  default=""
  description="Host port"
}

variable host_health_port {
  default=""
  description="Host health port"
}


variable "route53_record_name" {}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443]
}

locals {
  global_tags = {
    Team = var.team
    CostCat = var.cost_cat
    ManagedBy = var.managed_by
  }
}

variable "team" {
  description="Your team"
  default="default-team-terraform"
}

variable "cost_cat" {
  description="Your Cost Category"
  default="default-cost-cat-terraform"
}

variable "managed_by" {
  description="Owner"
  default="default-owner-terraform"
}

variable "docker_tag_version" {}
variable desired_count {}
variable ssl_policy {}
variable certificate_arn {}
variable route53_enabled {}
variable env {}
variable vpc_cidr {}
variable dns_domain_name {}
