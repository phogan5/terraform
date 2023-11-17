provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_ec2_instance_connect_endpoint" "app_subnet_instance_connect_endpoint" {
  subnet_id = var.subnet-app-1a

  tags = {
    Name = "app-1a"
  }
}