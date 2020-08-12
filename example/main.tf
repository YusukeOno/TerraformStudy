resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0e593a21b30d6547d"

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}
