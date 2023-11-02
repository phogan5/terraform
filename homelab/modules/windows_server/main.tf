


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
    vpc_security_group_ids = [var.sg_id]
    subnet_id = var.subnet_id
    private_ip = "172.31.0.110"
    

    tags = {
      "Name" = "hl_win_server_22"
      "tf_managed" = "True"
      "tf_repo" = "terraform/homelab/resources/windows_server/"
      "secret_key" = local.db_creds.username
      "secret_value" = local.db_creds.password
    }
}






##TODO: 
#- Modularize folder structure
#- Set static DNS names so I dont have to get a new password/ssh command everytime I create instance
#- Create .ps user data script for hl_win_server_22 to create firewall rule to allow ICMP (and other) connections.