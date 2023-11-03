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
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7500::/64"

  tags = {
    Name = "sn-reserved-1a"
  }
}

resource "aws_subnet" "sn-db-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.16.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7501::/64"

  tags = {
    Name = "sn-db-1a"
  }
}

resource "aws_subnet" "sn-app-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.32.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7502::/64"

  tags = {
    Name = "sn-app-1a"
  }
}

resource "aws_subnet" "sn-web-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.48.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7503::/64"

  tags = {
    Name = "sn-web-1a"
  }
}

resource "aws_subnet" "sn-reserved-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.64.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7504::/64"

  tags = {
    Name = "sn-reserved-1b"
  }
}

resource "aws_subnet" "sn-db-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.80.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7505::/64"

  tags = {
    Name = "sn-db-1b"
  }
}

resource "aws_subnet" "sn-app-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.96.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7506::/64"

  tags = {
    Name = "sn-app-1b"
  }
}

resource "aws_subnet" "sn-web-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.112.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7507::/64"

  tags = {
    Name = "sn-web-1b"
  }
}

resource "aws_subnet" "sn-reserved-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.128.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7508::/64"

  tags = {
    Name = "sn-reserved-1c"
  }
}

resource "aws_subnet" "sn-db-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.144.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:7509::/64"

  tags = {
    Name = "sn-db-1c"
  }
}

resource "aws_subnet" "sn-app-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.160.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:750A::/64"

  tags = {
    Name = "sn-app-1c"
  }
}

resource "aws_subnet" "sn-web-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.176.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:4245:750B::/64"

  tags = {
    Name = "sn-web-1c"
  }
}