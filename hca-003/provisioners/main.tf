provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "web" {
    ami =           "ami-0dfcb1ef8550277af"
    instance_type = "t2.micro"

    provisioner "local-exec" {
        command = "echo ${self.private_ip} >> private_ips.txt"
        #working_dir = ~/home

        #command = "Get-Date > completed.txt"
        #interpreter = ["Powershell", "-Command"]

        #environment = {
        #    KEY = "XXXXXXXXXXXXXXXXXX"
        #    SECRET = "ZZZZZZZZZZZZZZZZZZZZZZZZZZ"
        #}
    }
}