######################################################## CloudWatch Log ########################################################

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "${var.ecs_service_name}-LogGroup"
  retention_in_days = "7"
}

