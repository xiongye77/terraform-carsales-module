resource "aws_security_group" "carsales_alb_sg" {
  vpc_id = var.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name        = "CarSales ALB Security Group"
    Terraform   = "True"
  }
}

# Create Application Load Balancer

resource "aws_lb" "carsales_alb" {
  name               = "carsales-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.carsales_alb_sg.id]
  subnets = var.vpc_subnets
  
  enable_deletion_protection = false
  tags = {
    Name        = "CarSales Application Load Balancer"
    Terraform   = "True"
  }
}


resource "aws_lb_listener" "carsales_http" {
  load_balancer_arn = aws_lb.carsales_alb.arn
  #port = 443
  port = 80
  protocol = "HTTP"
  #protocol = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-TLS-1-0-2015-04"
  #certificate_arn   = var.certificate_arn
  default_action {
  type = "forward"
  target_group_arn = aws_lb_target_group.carsales-back-end-tg-1.arn
  }
}

#resource "aws_lb_listener" "carsales_https_redirect" {
#  load_balancer_arn = aws_lb.carsales_alb.arn
#  port              = "80"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "redirect"
#    redirect {
#      port        = "443"
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
#  }
#}

resource "aws_lb_listener_rule" "carsales_test1_http" {
  listener_arn = aws_lb_listener.carsales_http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.carsales-back-end-tg-1.arn
  }
    condition {
    path_pattern {
      values = ["/carsales1/"]
    }
  }
}


resource "aws_lb_listener_rule" "carsales_test2_http" {
  listener_arn = aws_lb_listener.carsales_http.arn
  priority     = 200
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.carsales-back-end-tg-2.arn
  }
    condition {
    path_pattern {
      values = ["/carsales2/"]
    }
  }
}

resource "aws_lb_target_group" "carsales-back-end-tg-1" {
  port = 80
  protocol = "HTTP"
  name = "carsales-back-end-tg-1"
  vpc_id = var.vpc_id
  stickiness {
    type = "lb_cookie"
    enabled = true
  }
  health_check {
    protocol = "HTTP"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 10
  }
  tags = {
    Name        = "CarSales Back End Target Group 1"
    Terraform   = "True"
  }
}

resource "aws_lb_target_group" "carsales-back-end-tg-2" {
  name                 = "carsales-back-end-tg-2"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = "30"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
    interval            = 10
  }
  tags = {
    Name        = "CarSales Back End Target Group 2"
    Terraform   = "True"
  }

}

