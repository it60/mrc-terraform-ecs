resource "aws_route53_zone" "mrcit94_dev" {
  name = var.dns_domain_name
  comment = ""
}