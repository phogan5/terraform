terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "tf-secret"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_instance" "windows_server" {
    ami = "ami-0bde1eb2c18cb2abe" #Microsoft Windows Server 2022 Base
    instance_type = "t2.medium"
    key_name = "us-east-1"
    vpc_security_group_ids = [aws_security_group.homelab-sg.id]
    subnet_id = "subnet-0e1767c810b88f50e"
    private_ip = "172.31.0.110" 
    

    tags = {
      "Name" = "hl_win_server_22"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/resources/windows_server/"
      "secret_key" = local.db_creds.username
      "secret_value" = local.db_creds.password
    }
}

resource "aws_instance" "redhat_server" {
    ami = "ami-016eb5d644c333ccb" #Red Hat Enterprise Linux 9 (HVM), SSD Volume Type
    instance_type = "t2.micro"
    key_name = "us-east-1"
    vpc_security_group_ids = [aws_security_group.homelab-sg.id]
    subnet_id = "subnet-0e1767c810b88f50e"
    private_ip = "172.31.0.120"


    tags = {
      "Name" = "hl_redhat"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/resources/windows_server/"
    }
}

resource "aws_security_group" "homelab-sg" {
    name = "homelab-sg"
    vpc_id = "vpc-08b6a277deb2d6942"

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


##TODO: 
#- Modularize folder structure
#- Set static DNS names so I dont have to get a new password/ssh command everytime I create instance
#- Create .ps user data script for hl_win_server_22 to create firewall rule to allow ICMP (and other) connections.