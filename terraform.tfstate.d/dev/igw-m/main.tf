resource "aws_internet_gateway" "tp_igw" {
  vpc_id = var.igw_vpc_id
  
  tags = {
    Name = var.igw_name
  }
}