variable "tp_rt_vpcid" {
  type = string
}

variable "rt_routes" {
  description = "List of routes for the route table"
  type        = list(object({
    cidr_block = string
    gateway_id = optional(string)
    nat_gateway_id = optional(string)
    transit_gateway_id = optional(string)
  }))
  default = []
}

variable "tp_rt_name" {
  type = string
}

