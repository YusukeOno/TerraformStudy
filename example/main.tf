variable "example_instance_type" {
  default = "t3.micro"
}

locals {
  example_subnet_id = "subnet-0e593a21b30d6547d"
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = var.example_instance_type
  subnet_id     = local.example_subnet_id

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}
