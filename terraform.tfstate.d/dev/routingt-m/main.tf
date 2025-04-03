resource "aws_route_table" "tp_routingtable" {
  
  vpc_id = var.tp_rt_vpcid
  dynamic "route" {
    for_each = var.rt_routes
    content {
      cidr_block        = route.value.cidr_block
      gateway_id        = lookup(route.value, "gateway_id", null)
      nat_gateway_id    = lookup(route.value, "nat_gateway_id", null)
      transit_gateway_id = lookup(route.value, "transit_gateway_id", null)
    }
  }
  tags = {
    Name = var.tp_rt_name
  }
}