terraform {

  backend "s3" {
    bucket = "phogan-tf-state"
    key = "first_ec2"
    dynamodb_table = "terraform-backend-locks"
    region = "us-east-1"
    encrypt = true
  }
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

resource "aws_instance" "terraform_instance" {
  ami           = "ami-0dfcb1ef8550277af"
  instance_type = "t2.micro"


  tags = {
    Name  = "terraform_ec2"
    Color = "Pink"
    Key   = "Value"
  }
}

