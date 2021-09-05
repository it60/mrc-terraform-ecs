output "vpc_id" {
  value = aws_vpc.sg-default-vpc.id
}

output "aws_subnet_demo_ids" {
  value = aws_subnet.demo.*.id
}

output "aws_route53_zone_id" {
  value = aws_route53_zone.mrcit94_dev.id
}