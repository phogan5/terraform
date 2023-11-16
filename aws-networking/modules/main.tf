terraform {
  backend "s3" {
    bucket  = "phogan-tf-state"
    key     = "aws-networking/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source        = "./ec2"
  vpc_id        = module.vpc.vpc_id
  ec2_profile   = module.iam.ec2_profile
  subnet-web-1a = module.vpc.subnet-web-1a
  web_sg        = module.vpc.web_sg
}

module "iam" {
  source = "./iam"
}