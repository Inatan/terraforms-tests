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
  region  = "sa-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04473c3d3be6a927f"
  instance_type = "t2.micro"
  key_name = "iac-ina"
  user_data = <<-EOF
                #!/bin/bash
                cd /home/ubuntu
                echo “<h1>Mensagem a ser mostrada</h1>” > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
  tags = {
    Name = "Terraform hello world"
  }
}