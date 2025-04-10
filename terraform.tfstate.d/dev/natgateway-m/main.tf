resource "aws_eip" "nat_eip" {
  vpc = true

}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.nat_subnetid

  tags = {
    Name = "NAT Gateway"
  }
}