provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = "10"
  instance_class = "db.t2.micro"
  skip_final_snapshot = true
  db_name = "example_database"

  #How to set username and password?
  username = var.db_username
  password = var.db_password
}