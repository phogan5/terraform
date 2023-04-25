provider "aws" {
  region = "us-east-1"
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