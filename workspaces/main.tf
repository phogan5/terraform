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
   ami = "ami-0dfcb1ef8550277af"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}



