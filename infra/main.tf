terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = var.regiao_aws
}

resource "aws_launch_template" "maquina" {
  image_id = "ami-04473c3d3be6a927f"
  instance_type = var.instancia
  key_name = var.chave
  # user_data = <<-EOF
  #               #!/bin/bash
  #               cd /home/ubuntu
  #               echo "<h1>Mensagem a ser mostrada</h1>" > index.html
  #               nohup busybox httpd -f -p 8080 &
  #               EOF
  security_group_names = [var.grupo_seguranca]
  tags = {
    Name = "Terraform hello world"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

# output IP_Publico {
#   value       = aws_launch_template.app_server.public_ip
# }

resource "aws_autoscaling_group" "grupo" {
  name = var.nome_grupo
  max_size = var.max
  min_size = var.min
  availability_zones = ["${var.regiao_aws}a","${var.regiao_aws}c"]
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [ ] #[ aws_lb_target_group.target_lb.arn ]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}c"
}

resource "aws_lb" "lb" {
  internal = false
  subnets = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
}

resource "aws_lb_target_group" "target_lb" {
  name = "TG"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_default_vpc" "default"{

}

resource "aws_lb_listener" "entrada_lb"{
  load_balancer_arn = aws_lb.lb.arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_lb.arn
  }
}

# resource "aws_autoscaling_policy" "escala-prd" {
#   name = "terraform-escala"
#   autoscaling_group_name = var.nome_grupo
#   policy_type = "TargetTrackingScaling"
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = 50.0
#   }
# }