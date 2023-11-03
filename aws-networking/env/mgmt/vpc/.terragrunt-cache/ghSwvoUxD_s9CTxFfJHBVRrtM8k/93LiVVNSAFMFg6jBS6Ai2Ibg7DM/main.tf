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
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_vpc" "a4l-vpc1" {
  cidr_block                       = var.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "a4l-vpc1"
  }
}

resource "aws_subnet" "sn-reserved-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.0.0/20"
  #assign_ipv6_address_on_creation = true
  #ipv6_cidr_block                 = "2600:1f18:3ae6:4600::/64"

  tags = {
    Name = "sn-reserved-1a"
  }
}

resource "aws_subnet" "sn-db-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.16.0/20"
  #assign_ipv6_address_on_creation = true
  #ipv6_cidr_block                 = "2600:1f18:3ae6:4601::/64"

  tags = {
    Name = "sn-db-1a"
  }
}

resource "aws_subnet" "sn-app-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.32.0/20"
  #assign_ipv6_address_on_creation = true
  #ipv6_cidr_block                 = "2600:1f18:3ae6:4602::/64"

  tags = {
    Name = "sn-app-1a"
  }
}

resource "aws_subnet" "sn-web-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.48.0/20"
  #assign_ipv6_address_on_creation = true
  #ipv6_cidr_block                 = "2600:1f18:3ae6:4603::/64"

  tags = {
    Name = "sn-web-1a"
  }
}
