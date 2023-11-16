provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

//todo get vpc flow logs to work to track traffic between the two instances
resource "aws_instance" "ec2_1" {
  ami                  = var.ami
  instance_type        = "t3.micro"
  subnet_id            = var.subnet-web-1a
  key_name             = "us-east-1"
  iam_instance_profile = var.ec2_profile
  security_groups      = [var.web_sg]

  tags = {
    Name = "a4l-bastion-host"
  }
}