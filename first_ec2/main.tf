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
  region  = "us-east-1"
}

resource "aws_instance" "test_instance" {
  ami             = "ami-0fc63309341f435f9"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-0e146269065c4aec5"
  security_groups = ["sg-0a1dfe7fa79c68b2e"]
  key_name        = "is-deploy"

  tags = {
    Name = "BuiltWithTerraf0rm"
  }
}
