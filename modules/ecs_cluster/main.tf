data "template_file" "cluster-init" {
  template = "${file("userdata.tpl")}"
  vars = {
    cluster_name = var.ecs_cluster_name
  }
}

# Create ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs_cluster_name
}