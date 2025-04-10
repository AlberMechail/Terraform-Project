variable "tp_privateec2_ami" {
  type = string
}

variable "tp_privateec2_instancetype" {
  type = string
}

variable "privateec2_subnetid" {
  type = string
}

variable "privateec2_securitygroup" {
  type = list(string)
}

variable "privateec2_associatepublicip" {
  type = bool
}

variable "privateec2_name" {
  type = string
}

variable "privateec2_target_group_arn" {
  type = string
}

variable "private_key_path" {
  description = "Path to the SSH private key for remote-exec."
  type        = string
  default = "~/Downloads/labuser.pem"
}

