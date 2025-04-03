resource "aws_subnet" "tp_subnet" {
    
  vpc_id     = var.tp_subnet_vpcid
  cidr_block = var.tp_subnet_cidrblock
  availability_zone = var.tp_subnet_availabilityzone
  tags = {
    Name = var.tp_subnet_name
  }
  map_public_ip_on_launch = var.publicorprivate
}

