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
  type = list(string)
}

variable "ec2_associatepublicip" {
  type = bool
}

variable "ec2_name" {
  type = string
}

variable "ec2_target_group_arn" {
  type = string
}

variable "private_key_path" {
  description = "Path to the SSH private key for remote-exec."
  type        = string
  default = "/home/albermechail/Downloads/labuser.pem"
}

