
# Listeners and default Rules
resource "aws_lb_listener" "http80" {
  load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django.arn
  }
 }

resource "aws_lb_listener" "https443" {
  load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "8080"
  protocol          = "HTTP"
  #ssl_policy        = var.listener_ssl_policy
  #certificate_arn   = var.listener_certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
 }

# Listener Rules other than defaults
resource "aws_lb_listener_rule" "http80-rules" {
  listener_arn = aws_lb_listener.http80.arn
  priority     = 100
  action {
    type          = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  condition {
    host_header {
      values = [var.django-fqdn]
    }
  }
}

resource "aws_lb_listener_rule" "https443-rules-django" {
  listener_arn = aws_lb_listener.https443.arn
  priority     = 101
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django.arn
  }
  condition {
    host_header {
      values = [
          var.django-fqdn,
          var.ca-portal-fqdn,
          var.ops-portal-fqdn
      ]
    }
  }
}

resource "aws_lb_listener_rule" "https443-rules-bpm" {
  listener_arn = aws_lb_listener.https443.arn
  priority     = 102
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bpm.arn
  }
  condition {
    host_header {
      values = [var.bpm-fqdn]
    }
  }
}

resource "aws_lb_listener_rule" "https443-rules-frontend" {
  listener_arn = aws_lb_listener.https443.arn
  priority     = 103
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
  condition {
    host_header {
      values = [var.frontend-fqdn]
    }
  }
}