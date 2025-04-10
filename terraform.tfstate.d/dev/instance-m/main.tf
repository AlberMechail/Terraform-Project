resource "aws_instance" "tp_ec2" {
  ami = var.tp_ec2_ami
  instance_type = var.tp_ec2_instancetype
  subnet_id = var.ec2_subnetid

  vpc_security_group_ids = var.ec2_securitygroup
  associate_public_ip_address = var.ec2_associatepublicip
  tags = {
    Name = var.ec2_name
    }

  # Log public IPs to all-ips.txt
   # Dynamic block to conditionally add local-exec provisioner
  provisioner "local-exec" {
      command = "echo ${var.ec2_name} ${self.public_ip} >> ~/.aws/all-ips.txt"
  }

  # Dynamic block to conditionally add remote-exec provisioner
  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
  }

  provisioner "remote-exec" {
      inline  = [
        "sudo apt-get update -y",
        "sudo apt-get install -y apache2",
        "sudo systemctl start apache2",
        "sudo systemctl enable apache2"
      ]
  }   
  }

  resource "aws_lb_target_group_attachment" "attach_lb_toInstance" {
    target_group_arn = var.ec2_target_group_arn
    target_id        = aws_instance.tp_ec2.id
    port             = 80
  }