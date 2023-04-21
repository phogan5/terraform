terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "windows_server" {
    ami = "ami-0bde1eb2c18cb2abe" #Microsoft Windows Server 2022 Base
    instance_type = "t2.micro"
    key_name = "us-east-1"
    security_groups = [aws_security_group.homelab-sg.name]

    tags = {
      "Name" = "win_server_22"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/resources/windows_server/"
    }
}

resource "aws_security_group" "homelab-sg" {
    name = "homelab-general"

    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["68.60.46.52/32"]
    }
}