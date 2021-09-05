resource "aws_vpc" "sg-default-vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "sg-default-vpc"
  }
}