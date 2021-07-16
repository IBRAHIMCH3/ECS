# Create Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.env_name}-alb"
  internal           = var.alb_scheme
  load_balancer_type = var.load_balancer_type 
  security_groups    = var.ecs_lb_sg
  subnets            = var.ecs_lb_subnets
}
