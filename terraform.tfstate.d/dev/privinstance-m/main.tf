resource "aws_instance" "tp_privateec2" {
  ami = var.tp_privateec2_ami
  instance_type = var.tp_privateec2_instancetype
  subnet_id = var.privateec2_subnetid

  vpc_security_group_ids = var.privateec2_securitygroup
  associate_public_ip_address = var.privateec2_associatepublicip
  tags = {
    Name = var.privateec2_name
    }

  # user_data = ""
  }

  resource "aws_lb_target_group_attachment" "attach_lb_toInstance" {
    target_group_arn = var.privateec2_target_group_arn
    target_id        = aws_instance.tp_privateec2.id
    port             = 22
  }