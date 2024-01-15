terraform {
  backend "remote" {
    organization = "example-org-4de848"

    workspaces {
      name = "generic-workspace"
    }
  }
  required_providers {
    aws = {
        version = "~>5.0"
        source = "hashicorp/aws"
    }
  }
}

  provider "aws" {
    region = "us-east-1"
  }


module "vpc" {
  source = "./modules/networking"
}

resource "null_resource" "example" {
  triggers = {
    value = "An example resource that does nothing"
  }
}