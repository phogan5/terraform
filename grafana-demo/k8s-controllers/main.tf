data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "k8s-node-master" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = "t2.medium"
    key_name = var.key_name
    subnet_id = var.k8s-subnet-controller.id

    tags = {
      "Name" = "k8s-node-master"
    }
}

resource "aws_instance" "k8s-node-worker-az1" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = "t2.micro"
    key_name = var.key_name
    subnet_id = var.k8s-subnet-az1.id

    tags = {
      "Name" = "k8s-node-worker-az1"
    }
}

resource "aws_instance" "k8s-node-worker-az2" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = "t2.micro"
    key_name = var.key_name
    subnet_id = var.k8s-subnet-az2.id

    tags = {
      "Name" = "k8s-node-worker-az2"
    }
}