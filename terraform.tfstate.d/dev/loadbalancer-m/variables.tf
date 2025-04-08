variable "lb_name" {
  type = string
}
variable "lb_isinternal" {
  type = bool
}
variable "lb_securitygroup" {
  type = list(string)
}
variable "lb_subnets" {
  type = list(string)
}
variable "lb_type" {
  type = string
}
variable "lbtarget_vpc_id" {
  type = string
}
variable "lb_target_group_port" {
  type = number
}
variable "lb_target_group_protocol" {
  type = string
}

variable "lb_listner_port" {
  type = number
}
variable "lb_listner_protocol" {
  type = string
}