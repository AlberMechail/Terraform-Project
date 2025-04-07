variable "sg_name" {
  type = string
}

variable "sg_vpcid" {
  type = string
}

variable "sg_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}