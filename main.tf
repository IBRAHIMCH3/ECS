
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


# Create the Auto_Scaling for our ecs clsuter
module "ec2_alb" {
    source               = "./modules/ec2_alb"

# Create the Target_group for our ecs clsuter
module "ec2_target_group" {
    source               = "./modules/ec2_target_group"


# Create the ecs_cluster for our ecs clsuter
module "ec2_cluster" {
    source               = "./modules/ec2_cluster"

# Create the ecs_serives for our ecs clsuter
module "ec2_services" {
    source               = "./modules/ec2_services"

# Create the ecs_task_deinitions for our ecs clsuter
module "ec2_task_definitions" {
    source               = "./modules/ec2_task_definitions"





 
  