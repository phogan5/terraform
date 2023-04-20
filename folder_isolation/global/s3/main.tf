provider "aws" {
  region = "us-east-1"
}

#backend configuration
terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key = "global/s3/s3_backend/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt = true
  }
}

#S3 bucket for storing tfstate files securely and remotely
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-backend-phi87819"

  #Prevent accidental deletion of the bucket -- even with tf destroy!
  lifecycle {
    prevent_destroy = true
  }
}

#Enable versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration{
    status = "Enabled"
  }
}

#Enable SSE
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
    bucket = aws_s3_bucket.terraform_state.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}

#Block public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

#Dynamodb table for locking tfstate files
resource "aws_dynamodb_table" "terraform_locks" {
  name = "tf-backend-phi87819"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}