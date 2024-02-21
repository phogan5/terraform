resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_security_group" "k8s-sg" {
  name = "k8s-cluster-sg"
  description = "Used for aws k8s ec2 nodes."
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "k8s-az1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/20"
}

resource "aws_subnet" "k8s-az2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.16.0/20"
}

resource "aws_subnet" "k8s-controller" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.32.0/20"
}

resource "aws_subnet" "k8s-az1-reserved" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.48.0/20"
}

resource "aws_subnet" "k8s-az2-reserved" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.64.0/20"
}