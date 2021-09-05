######################################################## ECS cluster ########################################################

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

######################################################## ECS task definition ########################################################

data "template_file" "ecs_task_definition_template" {
  template = file("${path.module}/task_definition.json")

  vars = {
    task_definition_name  = var.ecs_taskdef_name
    ecs_service_name      = var.ecs_service_name
    docker_container_port = var.docker_container_port
    src_ecr_repo_account  = var.src_ecr_repo_account
    src_ecr_region        = var.src_ecr_region
    docker_image          = var.docker_image
    docker_tag_version    = var.docker_tag_version
    managed_by            = var.managed_by
    aws_region            = var.aws_region
    env                   = var.env
  }
}

resource "aws_ecs_task_definition" "task" {

  container_definitions    = data.template_file.ecs_task_definition_template.rendered

  family                   = var.ecs_taskdef_name
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn       = aws_iam_role.fargate_iam_role.arn
  task_role_arn            = aws_iam_role.fargate_iam_role.arn
}

resource "aws_ecs_service" "service" {

  name            = var.ecs_service_name
  task_definition = aws_ecs_task_definition.task.arn
  #desired_count   = 1
  desired_count   = var.desired_count
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.app_security_group.id]
    assign_public_ip = true #If false: ResourceInitializationError: unable to pull secrets or registry auth: pull command failed: 
  }

  load_balancer {
    container_name   = var.container_name
    container_port   = var.docker_container_port
    target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
  }

  depends_on = [aws_lb_listener.ecs_lb_http_listener, aws_lb_listener.ecs_lb_http_listener2]
}
