resource "aws_vpc" "tp_vpc" {
  cidr_block = var.tp_vpc_cidrblock
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "TP_VPC"
  }
}