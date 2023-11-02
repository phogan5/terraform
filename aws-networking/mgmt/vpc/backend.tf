terraform {
    backend "s3" {
      bucket = "phogan-tf-state"
      key = "networking/mgmt/terraform.tfstate"
      region = "us-east-1"
      encrypt = true
    }
    
}