resource "aws_lb" "tp_loadbalancer" {
  name               = var.lb_name
  internal           = var.lb_isinternal
  load_balancer_type = var.lb_type
  security_groups    = var.lb_securitygroup
  subnets            = var.lb_subnets

  enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
  enable_http2      = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "tp_public_targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.lbtarget_vpc_id
  health_check {
    path = "/"
    interval = 30
    timeout  = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tp_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

