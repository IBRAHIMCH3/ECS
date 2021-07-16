resource "aws_ecs_service" "django" {
  name            = "${var.env_name}-django-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.django.arn
  desired_count   = var.django_tasks_count
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = aws_lb_target_group.django.arn
    container_name   = var.django-container_name
    container_port   = var.django-container_port
  }
}
resource "aws_ecs_service" "celery" {
  name            = "${var.env_name}-celery-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.celery.arn
  desired_count   = var.celery_tasks_count
  launch_type     = "EC2"
}
resource "aws_ecs_service" "bpm" {
  name            = "${var.env_name}-bpm-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.bpm.arn
  desired_count   = var.bpm_tasks_count
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = aws_lb_target_group.django.arn
    container_name   = var.bpm-container_name
    container_port   = var.bpm-container_port
  }
}
resource "aws_ecs_service" "frontend" {
  name            = "${var.env_name}-frontend-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = var.frontend_tasks_count
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = aws_lb_target_group.django.arn
    container_name   = var.frontend-container_name
    container_port   = var.frontend-container_port
  }
}