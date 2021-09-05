######################################################## ECS Security group ########################################################

resource "aws_security_group" "app_security_group" {
  name        = "SG-ECS-${var.ecs_service_name}"
  description = "Security group for app to communicate in and out"
  vpc_id   = var.vpc_id

  ingress {
    description = "Allow resource ${var.ecs_service_name} usage, common flow is VPC allow"
    from_port = var.docker_container_port
    protocol  = "TCP"
    to_port   = var.docker_container_port

    cidr_blocks = var.cidrs
    #cidr_blocks = var.vpc_id
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = local.global_tags
}

######################################################## ALB Security group ########################################################

resource "aws_security_group" "alb_sg" {
  name        = "SG-ALB-${var.ecs_service_name}"
  description = "Security group for ALB"
  vpc_id   = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = local.global_tags
}





