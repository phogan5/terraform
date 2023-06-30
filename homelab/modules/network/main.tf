provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "flow_log_s3" {
    tags = {
        "Name" = "secure_vpc_flow_logs"
    }
}


resource "aws_vpc" "secure_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "secure_vpc"
    }
}

resource "aws_flow_log" "tf_flow_log" {
  log_destination      = aws_s3_bucket.flow-log-bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.secure_vpc.id
}

resource "aws_s3_bucket" "flow-log-bucket" {
  bucket = "flow-log-bucket-phi87819"
}

resource "aws_internet_gateway" "tf_igw" {
    vpc_id = aws_vpc.secure_vpc.id
}

resource "aws_route_table" "tf_public_rt" {
    vpc_id = aws_vpc.secure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
    
}

resource "aws_subnet" "tf_subnet1" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "us-east-1a"

    tags = {
      "Name" = "private-1"
    }
}
resource "aws_subnet" "tf_subnet2" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "us-east-1b"
    tags = {
      "Name" = "private-2"
    }
}
resource "aws_subnet" "tf_subnet3" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.32.0/20"
    availability_zone = "us-east-1c"

    tags = {
      "Name" = "private-3"
    }
}
resource "aws_subnet" "tf_subnet4" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.48.0/20"
    availability_zone = "us-east-1d"

    tags = {
      "Name" = "public-1"
    }
}
resource "aws_subnet" "tf_subnet5" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.64.0/20"
    availability_zone = "us-east-1e"

    tags = {
      "Name" = "public-2"
    }
}
resource "aws_subnet" "tf_subnet6" {
    vpc_id = aws_vpc.secure_vpc.id
    cidr_block = "10.0.80.0/20"
    availability_zone = "us-east-1f"

    tags = {
      "Name" = "public-3"
    }
}


resource "aws_security_group" "homelab-sg" {
    name = "homelab-sg"
    vpc_id = aws_vpc.secure_vpc.id

        ingress {
        description = "rdp access"
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["68.60.46.52/32", "47.35.117.78/32"]
    }
        ingress {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["68.60.46.52/32", "47.35.117.78/32"]
    }
        ingress {
        description = "icmp"
        from_port = -1
        to_port = -1 #All ports
        protocol = "icmp"
        cidr_blocks = ["68.60.46.52/32"]
    }
        ingress {
        description = "icmp"
        from_port = -1
        to_port = -1 #All ports
        protocol = "icmp"
        cidr_blocks = ["172.31.0.0/20"]
    }
        egress {
        description = "icmp"
        from_port = -1
        to_port = -1 #All ports
        protocol = "icmp"
        cidr_blocks = ["172.31.0.0/20"]
    }

}