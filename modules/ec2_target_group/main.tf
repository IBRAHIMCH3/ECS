resource "aws_lb_target_group" "django" {
  name     = "${var.env_name}-django-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = var.lb_name
  health_check {
  interval = 30
  matcher = "200"
  path = "/static/index.html"
 }
}
# Celery target group is not required

resource "aws_lb_target_group" "bpm" {
  name     = "${var.env_name}-bpm-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = var.lb_name
  health_check {
  interval = 30
  matcher = "200"
  path = "/984763987324_rand_index.jsp"
 }
}
resource "aws_lb_target_group" "frontend" {
  name          = "${var.env_name}-frontend-tg"
  port          = 80
  protocol      = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = var.lb_name
  health_check {
  interval = 30
  matcher = "200"
  path = "/"
 }
}