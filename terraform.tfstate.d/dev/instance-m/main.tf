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
  provisioner "local-exec" {
    command = "echo ${var.ec2_name} ${self.public_ip} >> ~/.aws/all-ips.txt"
  }

  # Remote execution to install Apache or proxy
  connection {
    type        = "ssh"
    user        = "ec2-user"  # Update user based on your OS (e.g., ubuntu for Ubuntu)
    private_key = file("~/terraform_project/labuser.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2", # For Apache installation
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }

  }