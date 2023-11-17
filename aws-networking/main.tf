terraform {
  backend "s3" {
    bucket  = "phogan-tf-state"
    key     = "aws-networking/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "vpc" {
  source = "./modules/vpc"
  sn-reserved-1a = module.subnets.subnet-reserved-1a
  sn-reserved-1b = module.subnets.subnet-reserved-1b
  sn-reserved-1c = module.subnets.subnet-reserved-1c
  sn-db-1a = module.subnets.subnet-db-1a
  sn-db-1b = module.subnets.subnet-db-1b
  sn-db-1c = module.subnets.subnet-db-1c
  sn-app-1a = module.subnets.subnet-app-1a
  sn-app-1b = module.subnets.subnet-app-1b
  sn-app-1c = module.subnets.subnet-app-1c
  sn-web-1a = module.subnets.subnet-web-1a
  sn-web-1b = module.subnets.subnet-web-1b
  sn-web-1c = module.subnets.subnet-web-1c

}

module "subnets" {
  source = "./modules/vpc/subnets"
  vpc_id = module.vpc.vpc_id


}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  ec2_profile   = module.iam.ec2_profile
  subnet-web-1a = module.subnets.subnet-web-1a
  subnet-app-1a = module.subnets.subnet-app-1a
  web_sg        = module.vpc.web_sg
}

module "iam" {
  source = "./modules/iam"
}