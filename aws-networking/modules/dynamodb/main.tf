provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

locals {
  tf_data    = jsondecode(var.json_data)
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }


  tags = {
    Name        = "private-db"
    Description = "db only accessibly through instances in db subnets via gateway endpoint"
  }
}

resource "aws_dynamodb_table_item" "item-1" {
  table_name = aws_dynamodb_table.basic-dynamodb-table.name
  hash_key = aws_dynamodb_table.basic-dynamodb-table.hash_key

  for_each = local.tf_data
  item = jsonencode(each.value)
}