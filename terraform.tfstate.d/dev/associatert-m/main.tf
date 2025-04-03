resource "aws_route_table_association" "tp_rt_associate" {
  subnet_id = var.assrt_subnetid
  route_table_id = var.assrt_routetableid
}