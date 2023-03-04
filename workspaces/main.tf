provider "aws" {
  region = "us-east-1"
}

#backend
terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key = "workspaces-example/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  instance_type = "t2.micro"
}

