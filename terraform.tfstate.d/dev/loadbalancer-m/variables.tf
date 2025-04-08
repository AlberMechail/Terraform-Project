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