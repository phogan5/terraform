terraform {
  backend "s3" {
    bucket  = "phogan-tf-state"
    key     = "aws-networking/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      version = "~> 5.26.0"
    }
  }

}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/vpc/subnets"
  vpc_id = module.vpc.vpc_id
}

module "endpoints" {
  source = "./modules/vpc/endpoints"
  vpc_id = module.vpc.vpc_id
  subnet-app-1a = module.subnets.subnet-app-1a
  subnet-app-1b = module.subnets.subnet-app-1b
  subnet-app-1c = module.subnets.subnet-app-1c
  subnet-db-1a = module.subnets.subnet-db-1a
  subnet-db-1b = module.subnets.subnet-db-1b
  subnet-db-1c = module.subnets.subnet-db-1c
  natgw-1-rt = module.routing.natgw-1-rt
  natgw-2-rt = module.routing.natgw-2-rt
  natgw-3-rt = module.routing.natgw-3-rt


}

module "routing" {
  source         = "./modules/vpc/routing"
  vpc_id         = module.vpc.vpc_id
  sn-reserved-1a = module.subnets.subnet-reserved-1a
  sn-reserved-1b = module.subnets.subnet-reserved-1b
  sn-reserved-1c = module.subnets.subnet-reserved-1c
  sn-db-1a       = module.subnets.subnet-db-1a
  sn-db-1b       = module.subnets.subnet-db-1b
  sn-db-1c       = module.subnets.subnet-db-1c
  sn-app-1a      = module.subnets.subnet-app-1a
  sn-app-1b      = module.subnets.subnet-app-1b
  sn-app-1c      = module.subnets.subnet-app-1c
  sn-web-1a      = module.subnets.subnet-web-1a
  sn-web-1b      = module.subnets.subnet-web-1b
  sn-web-1c      = module.subnets.subnet-web-1c
}

module "security" {
  source = "./modules/vpc/security"
  vpc_id = module.vpc.vpc_id
  flow_log_role = module.iam.flow_log_role
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  ec2_profile   = module.iam.ec2_profile
  subnet-web-1a = module.subnets.subnet-web-1a
  subnet-app-1a = module.subnets.subnet-app-1a
  subnet-db-1a = module.subnets.subnet-db-1a
  web_sg        = module.security.web_sg
}

module "dynamodb" {
  source = "./modules/dynamodb"
  json_data  = file("./modules/dynamodb/db_data.json")

}

module "iam" {
  source = "./modules/iam"
}