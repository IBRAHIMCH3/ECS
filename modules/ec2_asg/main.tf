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


resource "aws_launch_configuration" "ecs-launch-config" {
  name_prefix     	     = "${var.env_name}-lc"
  image_id        	     = data.aws_ami.amazon-ecs-ami.id
  instance_type          = var.instance_type
  key_name               = var.keypair
  security_groups        = var.alb_security_groups
  user_data              = data.template_file.cluster-init.rendered
  #iam_instance_profile   = aws_iam_instance_profile.ecs-ec2-profile.id
  #iam_instance_profile = "arn:aws:iam::679430529045:role/ansible-test-role"
  lifecycle {
    create_before_destroy = true
  }
}


# This autoscaling group will take the above launch configuration and spin up/down the servers

resource "aws_autoscaling_group" "ecs-as-group" {
  name                 = "${var.env_name}-asg"
  launch_configuration = aws_launch_configuration.ecs-launch-config.name
  min_size             = var.min_instance_count
  max_size             = var.max_instance_count
  vpc_zone_identifier  = ["${var.ecs_asg_subnets[0]}"]
  lifecycle {
    create_before_destroy = true
  }
}