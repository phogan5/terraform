provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc_ipam" "tf_ipam" {
    operating_regions {
        region_name = "us-east-1"
    }
}

resource "aws_vpc_ipam_pool" "tf_ipam_pool" {
    address_family = "ipv4"
    ipam_scope_id = aws_vpc_ipam.tf_ipam.private_default_scope_id
    locale = "us-east-1"
}

resource "aws_vpc_ipam_pool_cidr" "tf_ipam_cidr" {
    ipam_pool_id = aws_vpc_ipam_pool.tf_ipam_pool.id
    cidr = "172.2.0.0/16"
  
}

resource "aws_vpc" "tf_vpc" {
    ipv4_ipam_pool_id = aws_vpc_ipam_pool.tf_ipam_pool.id
    ipv4_netmask_length = 25
    depends_on = [aws_vpc_ipam_pool_cidr.tf_ipam_cidr]

    tags = {
      "Name" = "secure_vpc"
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