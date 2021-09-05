resource "aws_subnet" "demo" {
  count             = var.az_count
  vpc_id            = aws_vpc.sg-default-vpc.id
  cidr_block        = "${var.vpc_cidr_base}${var.demo_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(", ", var.aws_azs), count.index)
  map_public_ip_on_launch = true

  tags = {
      "Name" = element(split(", ", var.demo_subnet_name), count.index)
  }
}

