provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_security_group" "web_sg" {
  name        = "a4l-web-sg"
  description = "Provides default traffic allowances"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
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