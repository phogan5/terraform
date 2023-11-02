provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "redhat_server" {
    ami = "ami-016eb5d644c333ccb" #Red Hat Enterprise Linux 9 (HVM), SSD Volume Type
    instance_type = var.instance_type
    key_name = "us-east-1"
    vpc_security_group_ids = [var.sg_id]
    subnet_id = var.subnet_id
    private_ip = "10.0.48.10"



    tags = {
      "Name" = "hl_redhat"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/modules/linux_server/"
    }
}

resource "aws_eip" "tf_eip" {
  vpc = true
  instance = aws_instance.redhat_server.id
}