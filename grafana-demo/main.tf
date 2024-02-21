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

module "networking-infra" {
  source = "./networking-infra"
}

module "k8s-controllers" {
  source = "./k8s-controllers"
  vpc_id = module.networking-infra.vpc_id
  k8s-subnet-az1 = module.networking-infra.k8s-az1
  k8s-subnet-az2 = module.networking-infra.k8s-az2
  k8s-subnet-controller = module.networking-infra.k8s-controller
  k8s-subnet-az1-reserved = module.networking-infra.k8s-az1-reserved
  k8s-subnet-az2-reserved = module.networking-infra.k8s-az2-reserved
}

