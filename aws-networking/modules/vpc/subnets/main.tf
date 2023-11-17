provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_subnet" "sn-reserved-1a" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.0.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d00::/64"

  tags = {
    Name = "sn-reserved-1a"
  }
}

resource "aws_subnet" "sn-db-1a" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.16.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d01::/64"

  tags = {
    Name = "sn-db-1a"
  }
}

resource "aws_subnet" "sn-app-1a" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.32.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d02::/64"

  tags = {
    Name = "sn-app-1a"
  }
}

resource "aws_subnet" "sn-web-1a" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.48.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:6068:d03::/64"

  tags = {
    Name = "sn-web-1a"
  }
}

resource "aws_subnet" "sn-reserved-1b" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.64.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d04::/64"

  tags = {
    Name = "sn-reserved-1b"
  }
}

resource "aws_subnet" "sn-db-1b" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.80.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d05::/64"

  tags = {
    Name = "sn-db-1b"
  }
}

resource "aws_subnet" "sn-app-1b" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.96.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d06::/64"

  tags = {
    Name = "sn-app-1b"
  }
}

resource "aws_subnet" "sn-web-1b" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.112.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:6068:d07::/64"

  tags = {
    Name = "sn-web-1b"
  }
}

resource "aws_subnet" "sn-reserved-1c" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.128.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d08::/64"

  tags = {
    Name = "sn-reserved-1c"
  }
}

resource "aws_subnet" "sn-db-1c" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.144.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d09::/64"

  tags = {
    Name = "sn-db-1c"
  }
}

resource "aws_subnet" "sn-app-1c" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.160.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:6068:d0a::/64"

  tags = {
    Name = "sn-app-1c"
  }
}

resource "aws_subnet" "sn-web-1c" {
  vpc_id                          = var.vpc_id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.176.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:6068:d0b::/64"

  tags = {
    Name = "sn-web-1c"
  }
}