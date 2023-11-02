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
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key    = "global/s3/web_server/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt        = true
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-0dfcb1ef8550277af"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_server.id]

  tags = {
    Name       = "Basic web server"
    CreateDate = "2/27/23"
  }

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.port_number} & 
                EOF

  user_data_replace_on_change = true
}

resource "aws_security_group" "web_server" {
  name = "web-server-traffic"

  ingress {
    from_port   = var.port_number
    to_port     = var.port_number
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "port_number" {
  description = "the tcp port to open the web server to"
  type        = number
  default     = "8080"

}
