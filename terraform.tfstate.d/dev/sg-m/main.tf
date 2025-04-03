resource "aws_security_group" "tp_securitygroup" {
  name        = var.sg_name
  vpc_id      = var.sg_vpcid

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.sg_name
  }

}