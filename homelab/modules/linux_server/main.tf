provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "redhat_server" {
    ami = "ami-016eb5d644c333ccb" #Red Hat Enterprise Linux 9 (HVM), SSD Volume Type
    instance_type = "t2.micro"
    key_name = "us-east-1"
    vpc_security_group_ids = [var.sg_id]
    subnet_id = var.subnet_id
    private_ip = "172.31.0.120"


    tags = {
      "Name" = "hl_redhat"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/modules/linux_server/"
    }
}