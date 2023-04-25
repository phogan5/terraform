provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "s3_backend" {
    bucket = "homelab-remote-backend87819"

    lifecycle {
      prevent_destroy = true
    }
}

#Bucket versioning
resource "aws_s3_bucket_versioning" "s3_backend_versioning" {
    bucket = aws_s3_bucket.s3_backend.id
    versioning_configuration {
        status = "Enabled"
    }
}

#Server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend_sse" {
    bucket = aws_s3_bucket.s3_backend.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

#Block public access
resource "aws_s3_bucket_public_access_block" "s3_backend_block_public_access" {
    bucket = aws_s3_bucket.s3_backend.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

#Dynamodb table for file locking
resource "aws_dynamodb_table" "homelab_locks" {
    name = "homelab_locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}
