terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key = "global/s3/first_ec2/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt = true
  }
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

