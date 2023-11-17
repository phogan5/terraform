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

resource "aws_flow_log" "a4l-flow-log" {
  iam_role_arn = var.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.flow-logging-log-group.arn
  traffic_type = "ALL"
  vpc_id = var.vpc_id
}

resource "aws_cloudwatch_log_group" "flow-logging-log-group" {
  name = "a4l-flow-logging"
  
}