resource "aws_lb" "tp_loadbalancer" {
  name               = var.lb_name
  internal           = var.lb_isinternal
  load_balancer_type = var.lb_type
  security_groups    = var.lb_securitygroup
  subnets            = var.lb_subnets

  enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
  enable_http2      = true 

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = var.lb_targetgroup_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = var.lbtarget_vpc_id
  health_check {
    path = "/"
    interval = 30
    timeout  = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "listner" {
  load_balancer_arn = aws_lb.tp_loadbalancer.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

