module "ecs-demo-prod" {
  source = "../../../modules/ecs-fargate"
  vpc_id                   = data.terraform_remote_state.common.outputs.vpc_id
  dns_mrcit94_dev_zone_id = data.terraform_remote_state.common.outputs.aws_route53_zone_id
  subnet_ids               = data.terraform_remote_state.common.outputs.aws_subnet_demo_ids

  src_ecr_region           = var.src_ecr_region
  src_ecr_repo_account     = var.src_ecr_repo_account
  route53_record_name      = var.route53_record_name
  cidrs                    = var.vpc_cidr
  container_name           = var.container_name
  docker_tag_version       = var.docker_tag_version
  
  docker_container_port        = var.docker_container_port
  docker_container_health_port = var.docker_container_health_port
  host_port = var.host_port
  host_health_port = var.host_health_port

  managed_by = var.managed_by
  aws_region= var.aws_region
  
  ecs_service_name = var.ecs_service_name
  ecs_cluster_name = var.ecs_cluster_name
  ecs_taskdef_name = var.ecs_taskdef_name
  docker_image = var.docker_image

  team = var.team
  cost_cat = var.cost_cat

  certificate_arn = var.certificate_arn
  ssl_policy = var.ssl_policy
  route53_enabled = var.route53_enabled
  env = var.env
  desired_count = var.desired_count
}