provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_instance" "ec2_jumpbox" {
  ami                  = var.ami
  instance_type        = "t3.micro"
  subnet_id            = var.subnet-web-1a
  key_name             = "us-east-1"
  iam_instance_profile = var.ec2_profile
  security_groups      = [var.web_sg]

  tags = {
    Name = "a4l-bastion-host"
    Description = "Publicly accessibly ec2 instance"
  }
}

resource "aws_instance" "ec2_private" {
  ami                  = var.ami
  instance_type        = "t3.micro"
  subnet_id            = var.subnet-app-1a
  key_name             = "us-east-1"
  iam_instance_profile = var.ec2_profile
  security_groups      = [var.web_sg]

  tags = {
    Name = "a4l-private-host"
    Description = "Can access the internet but cant be connected to"
  }
}