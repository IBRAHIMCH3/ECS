

resource "aws_instance" "main" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  tags              = var.tags 
  user_data         = var.user_data 
} 


