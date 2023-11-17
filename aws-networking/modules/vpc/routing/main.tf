provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}
resource "aws_internet_gateway" "primary_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "a4l-vpc1-igw"
  }
}

resource "aws_route_table" "primary_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.primary_igw.id
  }
  tags = {
    Name = "a4l-vpc1-rt-web"
  }
}

resource "aws_route_table_association" "public_rt_assoc_1a" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = var.sn-web-1a
  depends_on     = [aws_route_table.primary_rt]
}

resource "aws_route_table_association" "public_rt_assoc_1b" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = var.sn-web-1b
  depends_on     = [aws_route_table.primary_rt]

}

resource "aws_route_table_association" "public_rt_assoc_1c" {
  route_table_id = aws_route_table.primary_rt.id
  subnet_id      = var.sn-web-1c
  depends_on     = [aws_route_table.primary_rt]

}

resource "aws_route_table" "natgw-1-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-1.id
  }
  tags = {
    Name = "a4l-vpc1-rt-privateA"
  }
}

resource "aws_route_table_association" "natgw-1-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id      = var.sn-app-1a
}

resource "aws_route_table_association" "natgw-1-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id      = var.sn-db-1a
}

resource "aws_route_table_association" "natgw-1-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-1-rt.id
  subnet_id      = var.sn-reserved-1a
}

resource "aws_route_table" "natgw-2-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-2.id
  }
  tags = {
    Name = "a4l-vpc1-rt-privateB"
  }
}

resource "aws_route_table_association" "natgw-2-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id      = var.sn-app-1b
}

resource "aws_route_table_association" "natgw-2-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id      = var.sn-db-1b
}

resource "aws_route_table_association" "natgw-2-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-2-rt.id
  subnet_id      = var.sn-reserved-1b
}

resource "aws_route_table" "natgw-3-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-3.id
  }
  tags = {
    Name = "a4l-vpc1-rt-privateC"
  }
}

resource "aws_route_table_association" "natgw-3-rt-assoc-app" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id      = var.sn-app-1c
}

resource "aws_route_table_association" "natgw-3-rt-assoc-db" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id      = var.sn-db-1c
}

resource "aws_route_table_association" "natgw-3-rt-assoc-reserved" {
  route_table_id = aws_route_table.natgw-3-rt.id
  subnet_id      = var.sn-reserved-1c
}

###############################
#########nat gateways##########
###############################

resource "aws_nat_gateway" "natgw-1" {
  subnet_id     = var.sn-web-1a
  allocation_id = aws_eip.natgw-1-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-a"
  }
}

resource "aws_nat_gateway" "natgw-2" {
  subnet_id     = var.sn-web-1b
  allocation_id = aws_eip.natgw-2-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-b"
  }
}

resource "aws_nat_gateway" "natgw-3" {
  subnet_id     = var.sn-web-1c
  allocation_id = aws_eip.natgw-3-eip.id

  tags = {
    Name = "a4l-vpc1-natgw-c"
  }
}

resource "aws_eip" "natgw-1-eip" {
  tags = {
    Name = "a4l-vpc1-natgw-a-eip"
  }
}

resource "aws_eip" "natgw-2-eip" {

  tags = {
    Name = "a4l-vpc1-natgw-b-eip"
  }
}

resource "aws_eip" "natgw-3-eip" {
  tags = {
    Name = "a4l-vpc1-natgw-c-eip"
  }
}