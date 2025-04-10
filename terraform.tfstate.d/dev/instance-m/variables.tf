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

variable "enable_local_exec" {
  description = "Whether to run the local-exec provisioner."
  type        = bool
  default     = false  # Set to true to enable or false to disable
}

variable "enable_remote_exec" {
  description = "Whether to run the remote-exec provisioner."
  type        = bool
  default     = false  # Set to true to enable or false to disable
}

variable "private_key_path" {
  description = "Path to the SSH private key for remote-exec."
  type        = string
}

