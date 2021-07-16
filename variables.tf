# Environmental variables

############### EC2 Server ##################
variable "aws_region" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "ap-southeast-1"
} 

variable "ami" {
    description = "specify the AMI id to create the virtual machine"
    default     = ""
}

variable "instance_type" {
    description = "specify the instance class"
    default     = "t2.micro"
}

variable "subnet_id" {
    description = "specify the subnet where you want to create the instance"
    default     = "subnet-5b41eb2d"
}
variable "user_data " {
    description = "specify the subnet where you want to create the instance"
    default     = ""
}
############### ALB ###########################

variable "env_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "abfl-digital-kuliza-dev"
}


variable "alb-scheme" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "false"

}
variable "load_balancer_type" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "application"

}
variable "ecs_lb_sg" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = ["sg-0e0ec55efbcba451b"]

}
variable "ecs_lb_subnets" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = ["subnet-5b41eb2d", "subnet-125a7d54"]

}
############### ALb Listener ##############

variable "django-fqdn" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-django.abfldirect.com"
}
variable "ca-portal-fqdn" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ca-portal.abfldirect.com"
}
variable "ops-portal-fqdn" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ops-portal.abfldirect.com"
}
variable "bpm-fqdn" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-bpm.abfldirect.com"
}
variable "frontend-fqdn" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-frontend.abfldirect.com"
}

############################### Auto_scaling ####################
variable "instance_type" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "t2.micro"
}
variable "keypair" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "test-key"
}
variable "alb_security_groups" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "sg-0e0ec55efbcba451b"
}
variable "min_instance_count" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "1"
}
variable "max_instance_count" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "2"
}
variable "ecs_asg_subnets" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "subnet-5b41eb2dn n"
}

####################### Load_balancer Targrt_Group ###########
variable "vpc_id" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "vpc-f3f43097"
}
variable "lb_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "abfl-digital-kuliza-dev"
}
variable "env_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "abfl-digital-kuliza-dev"
}
############### ECS Cluster ###########

variable "ecs_cluster_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "abfl-digital-kuliza-dev"
}

############# ECS service ################

variable "env_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "abfl-digital-kuliza-dev"
}

# Django variables
variable "django_tasks_count" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "1"
}
variable "django-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-django-container"
}
variable "django-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "8000"
}

# Celery variables
variable "celery_tasks_count" 
    {description = "specify the environment name that will be added as a prefix to all resources"
    default     = "1"
}

# BPM variables
variable "bpm_tasks_count" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "1"
}
variable "bpm-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-bpm-container"
}
variable "bpm-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "8080"
}  

# Frontend variables
variable "frontend_tasks_count" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "1"
}
variable "frontend-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-frontend-container"
}
variable "frontend-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "80"
}  

######################  ECS_Task_Definitaion #########

# Django  variables
variable "django-awslogs-group" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-django-logs"
}
variable "django-awslogs-region" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "ap-southeast-1"
}
variable "django-awslogs-stream-prefix" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "/var/log/django-gunicorn-ng.login"
}
variable "django-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "8000"
}  
variable "django-cpu" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "100"
}
variable "django-memory" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "600"
}
variable "django-image" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "nginx:latest"
}
 
variable "django-labels" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-django-container"
}
variable "django-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-django-container"
}

# Celery  variables
variable "celery-awslogs-group" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-celery-logs"
}
variable "celery-awslogs-region" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "ap-southeast-1"
}
variable "celery-awslogs-stream-prefix" {description = "specify the environment name that will be added as a prefix to all resources"
    default     = ""
}
variable "celery-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "/var/log/celery"
    }  
variable "celery-cpu" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "100"
}
variable "celery-memory" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "512"
}
variable "celery-image" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "nginx:latest"
}
variable "celery-labels" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-celery-container"
}  
variable "celery-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-celery-container"
}

# BPM variables
variable "bpm-awslogs-group" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-bpm-logs"
}
variable "bpm-awslogs-region" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "ap-southeast-1"
}
variable "bpm-awslogs-stream-prefix" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "/opt/tomcat/logs/debug.log"
}
variable "bpm-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "8080"
}  
variable "bpm-cpu" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "100"
}
variable "bpm-memory" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "512"
}
variable "bpm-image" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "nginx:latest"
}
variable "bpm-labels" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = ""
}  
variable "bpm-container_name" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-bpm-container"
}

# Frontend variables
variable "frontend-awslogs-group" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-frontend-logs"
}
variable "frontend-awslogs-region" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "ap-southeast-1"
}
variable "frontend-awslogs-stream-prefix" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "/opt/tomcat/logs/debug.log"
}
variable "frontend-container_port" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "80"
}  
variable "frontend-cpu" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "100"
}
variable "frontend-memory" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "100"
}
variable "frontend-image" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "nginx:latest"
}
variable "frontend-labels" {
    description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-frontend-container"
}  
variable "frontend-container_name" {
description = "specify the environment name that will be added as a prefix to all resources"
    default     = "dr-ecs-frontend-container"
}



# EC2 and ALB Instance related variables
#variable "instance_type" {}
#variable "min_instance_count" {}
#variable "max_instance_count" {}
#variable "ecs_ec2_sg" { type = list(string)}
#variable "ecs_asg_subnets" { type = list(string)}
#variable "ecs_lb_sg" { type = list(string)}
#variable "ecs_lb_subnets" { type = list(string)}
#variable "listener_ssl_policy" {}        
#variable "listener_certificate_arn" {}   
