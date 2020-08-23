data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "example_instance_type" {
  default = "t3.micro"
}

locals {
  example_subnet_id = "subnet-0e593a21b30d6547d"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c3fd0f5d33134a76"
  instance_type          = var.example_instance_type
  subnet_id              = local.example_subnet_id
  vpc_security_group_ids = ["aws_security_group.example_ec2.id"]

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

resource "aws_security_group" "example_ec2" {
  name = "example-ec2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "example_instance_id" {
  value = aws_instance.example.id
}

output "example_public_dns" {
  value = aws_instance.example.public_dns
}
