terraform {
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
  profile = "terraform-user"
}

resource "aws_vpc" "a4l-vpc1" {
    cidr_block = "10.16.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    assign_generated_ipv6_cidr_block = true

    tags = {
        Name = "a4l-vpc1"
    }
}