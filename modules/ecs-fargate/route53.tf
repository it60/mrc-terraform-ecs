######################################################## Route53 Record ########################################################

resource "aws_route53_record" "ecs_demo_record" {
  count   = var.route53_enabled ? 1 : 0
  zone_id = var.dns_mrcit94_dev_zone_id
  name    = var.route53_record_name
  type    = "CNAME"
  ttl     = 60
  records = [ aws_lb.ecs_cluster_lb.dns_name ]
}

