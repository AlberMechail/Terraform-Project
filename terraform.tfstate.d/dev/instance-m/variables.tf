variable "tp_ec2_ami" {
  type = string
}

variable "tp_ec2_instancetype" {
  type = string
}

variable "ec2_subnetid" {
  type = string
}

variable "ec2_securitygroup" {
  type = string
}

variable "ec2_associatepublicip" {
  type = bool
}

variable "ec2_name" {
  type = string
}