
provider "aws" {
  region  = var.aws_region
    assume_role {
        role_arn     = "arn:aws:iam::${var.aws_account}:role/${var.aws_role}"
    }

}

# Create one ec2 instance for our cluster 

module "ec2_server" {
    source          = "./modules/ec2_server"
    ami             = var.ami
    instance_type   = var.instance_type
    subnet_id       = var.subnet_id
    user_data       = ""
    tags            = var.tags 
}

# Create the load balancer for our ecs clsuter

module "ec2_alb" {
    source               = "./modules/ec2_alb"
    env_name             = var.env_name
    alb_scheme           = var.alb_scheme
    load_balancer_type   = var.load_balancer_type
    ecs_lb_sg            = var.ecs_lb_sg
    ecs_lb_subnets       = var.ecs_lb_subnets 
}

# Create the listners for our ecs clsuter

module "ec2_alb_listeners" {
    source               = "./modules/ec2_alb_listeners"
    load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django.arn
  }
 


  load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "8080"
  protocol          = "HTTP"
  #ssl_policy        = var.listener_ssl_policy
  #certificate_arn   = var.listener_certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
 

# Listener Rules other than defaults

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
/*
# Create the Auto_Scaling for our ecs clsuter
module "ec2_asg" {
    source               = "./modules/ec2_asg"
    data "aws_ami" "amazon-ecs-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"] # Canonical
}


  name_prefix            = "${var.env_name}-lc"
  image_id               = data.aws_ami.amazon-ecs-ami.id
  instance_type          = var.instance_type
  key_name               = var.keypair
  security_groups        = var.alb_security_groups
  user_data              = data.template_file.cluster-init.rendered
  #iam_instance_profile   = aws_iam_instance_profile.ecs-ec2-profile.id
  #iam_instance_profile = "arn:aws:iam::679430529045:role/ansible-test-role"
  lifecycle {
    create_before_destroy = true
  }


  name                 = "${var.env_name}-asg"
  launch_configuration = aws_launch_configuration.ecs-launch-config.name
  min_size             = var.min_instance_count
  max_size             = var.max_instance_count
  vpc_zone_identifier  = ["${var.ecs_asg_subnets[0]}"]
  lifecycle {
    create_before_destroy = true
  }
}
*/
# Create the Target_group for our ecs clsuter
module "ec2_target_group" {
    source               = "./modules/ec2_target_group"
   name     = "${var.env_name}-django-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = var.lb_name
  health_check {
  interval = 30
  matcher = "200"
  path = "/static/index.html"
 




  name     = "${var.env_name}-bpm-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = var.lb_name
  health_check {
  interval = 30
  matcher = "200"
  path = "/984763987324_rand_index.jsp"
 


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

# Create the ecs_cluster for our ecs clsuter
module "ec2_cluster" {
  source               = "./modules/ec2_cluster"
  data "template_file" "cluster-init" {
  template = "${file("userdata.tpl")}"
  vars = {
    cluster_name = var.ecs_cluster_name
  }
}
}


# Create the ecs_serives for our ecs clsuter
module "ec2_services" {
    source               = "./modules/ec2_services"
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


  name            = "${var.env_name}-celery-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.celery.arn
  desired_count   = var.celery_tasks_count
  launch_type     = "EC2"


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
# Create the ecs_task_deinitions for our ecs clsuter
module "ec2_task_definitions" {
    source               = "./modules/ec2_task_definitions"
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

}




 
  
