provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "jenkins_server" {
  ami = "ami-09b25d4759bb6fab1"
  instance_type = "t2.medium"
  key_name = "us-east-1"
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id
  private_ip = "172.31.0.120"


  tags = {
      "Name" = "hl_jenkins"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/modules/jenkins_server/"
  }

}