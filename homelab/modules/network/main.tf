provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "flow_log_s3" {
    tags = {
        "Name" = "secure_vpc_flow_logs"
    }
}


resource "aws_vpc" "tf_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "secure_vpc"
    }
}

#resouce "aws_flow_log" "this" {
#https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/vpc-flow-logs.tf
#}

resource "aws_internet_gateway" "tf_igw" {
    vpc_id = aws_vpc.tf_vpc.id
}

resource "aws_subnet" "tf_subnet1" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "us-east-1a"

    tags = {
      "Name" = "private-1"
    }
}
resource "aws_subnet" "tf_subnet2" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "us-east-1b"
    tags = {
      "Name" = "private-2"
    }
}
resource "aws_subnet" "tf_subnet3" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.32.0/20"
    availability_zone = "us-east-1c"

    tags = {
      "Name" = "private-3"
    }
}
resource "aws_subnet" "tf_subnet4" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.48.0/20"
    availability_zone = "us-east-1d"

    tags = {
      "Name" = "public-1"
    }
}
resource "aws_subnet" "tf_subnet5" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.64.0/20"
    availability_zone = "us-east-1e"

    tags = {
      "Name" = "public-2"
    }
}
resource "aws_subnet" "tf_subnet6" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.0.80.0/20"
    availability_zone = "us-east-1f"

    tags = {
      "Name" = "public-3"
    }
}


resource "aws_security_group" "homelab-sg" {
    name = "homelab-sg"
    vpc_id = var.vpc_id

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