data "template_file" "django-td" {
  template = "${file("task-definitions/template.json")}"
  vars = {
    awslogs-group           = "${var.django-awslogs-group}"
    awslogs-region          = "${var.django-awslogs-region}"
    awslogs-stream-prefix   = "${var.django-awslogs-stream-prefix}"
    container_port          = "${var.django-container_port}"
    cpu                     = "${var.django-cpu}"
    memory                  = "${var.django-memory}"
    image                   = "${var.django-image}"
    labels                  = "${var.django-labels}"
    container_name          = "${var.django-container_name}"
  }
}

data "template_file" "celery-td" {
  template = "${file("task-definitions/template.json")}"
  vars = {
    awslogs-group           = "${var.celery-awslogs-group}"
    awslogs-region          = "${var.celery-awslogs-region}"
    awslogs-stream-prefix   = "${var.celery-awslogs-stream-prefix}"
    container_port          = "${var.celery-container_port}"
    cpu                     = "${var.celery-cpu}"
    memory                  = "${var.celery-memory}"
    image                   = "${var.celery-image}"
    labels                  = "${var.celery-labels}"
    container_name          = "${var.celery-container_name}"
  }
}

data "template_file" "bpm-td" {
  template = "${file("task-definitions/template.json")}"
  vars = {
    awslogs-group           = "${var.bpm-awslogs-group}"
    awslogs-region          = "${var.bpm-awslogs-region}"
    awslogs-stream-prefix   = "${var.bpm-awslogs-stream-prefix}"
    container_port          = "${var.bpm-container_port}"
    cpu                     = "${var.bpm-cpu}"
    memory                  = "${var.bpm-memory}"
    image                   = "${var.bpm-image}"
    labels                  = "${var.bpm-labels}"
    container_name          = "${var.bpm-container_name}"
  }
}

data "template_file" "frontend-td" {
  template = "${file("task-definitions/template.json")}"
  vars = {
    awslogs-group           = "${var.frontend-awslogs-group}"
    awslogs-region          = "${var.frontend-awslogs-region}"
    awslogs-stream-prefix   = "${var.frontend-awslogs-stream-prefix}"
    container_port          = "${var.frontend-container_port}"
    cpu                     = "${var.frontend-cpu}"
    memory                  = "${var.frontend-memory}"
    image                   = "${var.frontend-image}"
    labels                  = "${var.frontend-labels}"
    container_name          = "${var.frontend-container_name}"
  }
}

resource "aws_ecs_task_definition" "django" {
  family                = "${var.env_name}-django-task"
  container_definitions = data.template_file.django-td.rendered
}
resource "aws_ecs_task_definition" "celery" {
  family                = "${var.env_name}-celery-task"
  container_definitions = data.template_file.celery-td.rendered
}
resource "aws_ecs_task_definition" "bpm" {
  family                = "${var.env_name}-bpm-task"
  container_definitions = data.template_file.bpm-td.rendered
}
resource "aws_ecs_task_definition" "frontend" {
  family                = "${var.env_name}-frontend-task"
  container_definitions = data.template_file.frontend-td.rendered
}
