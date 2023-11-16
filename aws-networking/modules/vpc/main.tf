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

resource "aws_internet_gateway" "primary_igw" {
  vpc_id = aws_vpc.a4l-vpc1.id
  depends_on = [ aws_vpc.a4l-vpc1 ]

  tags = {
    Name = "a4l-vpc1-igw"
  }
}
//todo: figure out why $terraform destroy wont destroy the remaining "main" route table.
//workaround: manually delete the a4l VPC in the console (will delete associated IGW and RT)
resource "aws_route_table" "primary_rt" {
  vpc_id = aws_vpc.a4l-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.primary_igw.id
  }
  depends_on = [ aws_vpc.a4l-vpc1 ]
  tags = {
    Name = "a4l-vpc1-rt-web"
  }
}

resource "aws_route_table_association" "public_rt_assoc_1a" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = aws_subnet.sn-web-1a.id
  depends_on = [ aws_route_table.primary_rt ]
}

resource "aws_route_table_association" "public_rt_assoc_1b" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = aws_subnet.sn-web-1b.id
  depends_on = [ aws_route_table.primary_rt ]

}

resource "aws_route_table_association" "public_rt_assoc_1c" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = aws_subnet.sn-web-1c.id
  depends_on = [ aws_route_table.primary_rt ]

}

resource "aws_route_table" "natgw-1-rt" {
  vpc_id = aws_vpc.a4l-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-1.id
  }
  depends_on = [ aws_vpc.a4l-vpc1 ]
  tags = {
    Name = "a4l-vpc1-rt-privateA"
  }
}

resource "aws_route_table_association" "natgw-1-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id = aws_subnet.sn-app-1a.id
}

resource "aws_route_table_association" "natgw-1-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id = aws_subnet.sn-db-1a.id
}

resource "aws_route_table_association" "natgw-1-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id = aws_subnet.sn-reserved-1a.id
}

resource "aws_route_table" "natgw-2-rt" {
  vpc_id = aws_vpc.a4l-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-2.id
  }
  tags = {
    Name = "a4l-vpc1-rt-privateB"
  }
}

resource "aws_route_table_association" "natgw-2-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id = aws_subnet.sn-app-1b.id
}

resource "aws_route_table_association" "natgw-2-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id = aws_subnet.sn-db-1b.id
}

resource "aws_route_table_association" "natgw-2-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id = aws_subnet.sn-reserved-1b.id
}

resource "aws_route_table" "natgw-3-rt" {
  vpc_id = aws_vpc.a4l-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-3.id
  }
  tags = {
    Name = "a4l-vpc1-rt-privateC"
  }
}

resource "aws_route_table_association" "natgw-3-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id = aws_subnet.sn-app-1c.id
}

resource "aws_route_table_association" "natgw-3-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id = aws_subnet.sn-db-1c.id
}

resource "aws_route_table_association" "natgw-3-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id = aws_subnet.sn-reserved-1c.id
}

resource "aws_security_group" "web_sg" {
  name        = "a4l-web-sg"
  description = "Provides default traffic allowances"
  vpc_id      = aws_vpc.a4l-vpc1.id

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_nat_gateway" "natgw-1" {
  subnet_id = aws_subnet.sn-web-1a.id
  allocation_id = aws_eip.natgw-1-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-a"
  }
}

resource "aws_nat_gateway" "natgw-2" {
  subnet_id = aws_subnet.sn-web-1b.id
  allocation_id = aws_eip.natgw-2-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-b"
  }
}

resource "aws_nat_gateway" "natgw-3" {
  subnet_id = aws_subnet.sn-web-1c.id
  allocation_id = aws_eip.natgw-3-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-c"
  }
}

resource "aws_eip" "natgw-1-eip" {
  depends_on = [aws_internet_gateway.primary_igw]

  tags = {
    Name = "a4l-vpc1-natgw-a-eip"
  }
}

resource "aws_eip" "natgw-2-eip" {
  depends_on = [aws_internet_gateway.primary_igw]

  tags = {
    Name = "a4l-vpc1-natgw-b-eip"
  }
}

resource "aws_eip" "natgw-3-eip" {
  depends_on = [aws_internet_gateway.primary_igw]

  tags = {
    Name = "a4l-vpc1-natgw-c-eip"
  }
}

resource "aws_subnet" "sn-reserved-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.0.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1800::/64"

  tags = {
    Name = "sn-reserved-1a"
  }
}

resource "aws_subnet" "sn-db-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.16.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1801::/64"

  tags = {
    Name = "sn-db-1a"
  }
}

resource "aws_subnet" "sn-app-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.32.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1802::/64"

  tags = {
    Name = "sn-app-1a"
  }
}

resource "aws_subnet" "sn-web-1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.16.48.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1803::/64"

  tags = {
    Name = "sn-web-1a"
  }
}

resource "aws_subnet" "sn-reserved-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.64.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1804::/64"

  tags = {
    Name = "sn-reserved-1b"
  }
}

resource "aws_subnet" "sn-db-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.80.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1805::/64"

  tags = {
    Name = "sn-db-1b"
  }
}

resource "aws_subnet" "sn-app-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.96.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1806::/64"

  tags = {
    Name = "sn-app-1b"
  }
}

resource "aws_subnet" "sn-web-1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1b"
  cidr_block                      = "10.16.112.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1807::/64"

  tags = {
    Name = "sn-web-1b"
  }
}

resource "aws_subnet" "sn-reserved-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.128.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1808::/64"

  tags = {
    Name = "sn-reserved-1c"
  }
}

resource "aws_subnet" "sn-db-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.144.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:1809::/64"

  tags = {
    Name = "sn-db-1c"
  }
}

resource "aws_subnet" "sn-app-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.160.0/20"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = "2600:1f18:57e0:180a::/64"

  tags = {
    Name = "sn-app-1c"
  }
}

resource "aws_subnet" "sn-web-1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.176.0/20"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = "2600:1f18:57e0:180b::/64"

  tags = {
    Name = "sn-web-1c"
  }
}