provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

//todo get vpc flow logs to work to track traffic between the two instances
resource "aws_instance" "ec2_1"{
    ami = var.ami
    instance_type = "t3.micro"
    key_name = aws_key_pair.demo_ec2_keypair.key_name
    count = 2
    subnet_id = var.subnet-app-1a
}

//todo give instances a "real" key pair to connect with
resource "aws_key_pair" "demo_ec2_keypair" {
  key_name_prefix   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "ec2_default_security_group" {
    name = "launch-wiard-fuck-you"
}