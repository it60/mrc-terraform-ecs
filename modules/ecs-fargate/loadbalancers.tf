######################################################## ALB ########################################################
resource "aws_lb" "ecs_cluster_lb" {
  name            = "ALB-${var.ecs_service_name}"
  internal        = false
  subnets         = var.subnet_ids

  load_balancer_type = "application"
  #enable_cross_zone_load_balancing = false

  security_groups    = [aws_security_group.alb_sg.id]

  tags = local.global_tags
}


######################################################## Target group ########################################################
resource "aws_lb_target_group" "ecs_app_target_group" {
  name        = "TG-ECS-${var.ecs_service_name}"
  port        = var.docker_container_health_port
  protocol    = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  tags = local.global_tags
  
  health_check {
    enabled             = true
    port                = var.docker_container_health_port
    protocol            = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 15
    interval = 30
  }
}

######################################################## Listener ########################################################

resource "aws_lb_listener" "ecs_lb_http_listener" {
  #load_balancer_arn = var.load_balancer_arn
  load_balancer_arn = aws_lb.ecs_cluster_lb.id
  port              = var.host_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
  }

  depends_on = [aws_lb_target_group.ecs_app_target_group]
}

resource "aws_lb_listener" "ecs_lb_http_listener2" {
  #load_balancer_arn = var.load_balancer_arn
  load_balancer_arn = aws_lb.ecs_cluster_lb.id
  port              = var.host_health_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
  }

  depends_on = [aws_lb_target_group.ecs_app_target_group]
}


