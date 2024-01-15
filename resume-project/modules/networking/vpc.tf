resource "aws_vpc" "primary_vpc" {
    cidr_block = var.primary_vpc_cidr
    instance_tenancy = "default"
    tags = {
        Name = "web_app_vpc"
        Description = "The primary VPC for web app testing. Built using terraform from https://github.com/phogan5/terraform"
    }
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id = aws_vpc.primary_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.az1
  tags = {
    Name = "public_subnet_az1"
  }
}
resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.primary_vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.az2
  tags = {
    Name = "public_subnet_az2"
  }
}
resource "aws_subnet" "private_subnet_az1" {
  vpc_id = aws_vpc.primary_vpc.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.az1
  tags = {
    Name = "private_subnet_az1"
  }
}
resource "aws_subnet" "private_subnet_az2" {
  vpc_id = aws_vpc.primary_vpc.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.az2
  tags = {
    Name = "private_subnet_az2"
  }
}