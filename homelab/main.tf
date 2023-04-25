provider "aws" {
  region = "us-east-1"
}

terraform {
    backend "s3" {
      bucket = "homelab-remote-backend87819"
      key = "global/s3/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "homelab_locks"
      encrypt = true 
    }
}

module "remote_datastore" {
    source = "/Users/phogan5/terraform/homelab/data_stores"

}

module "homelab_network" {
    source = "/Users/phogan5/terraform/homelab/modules/network"

    vpc_id = "vpc-08b6a277deb2d6942"
}

module "linux_server" {
    source = "/Users/phogan5/terraform/homelab/modules/linux_server"

    sg_id = "${module.homelab_network.sg_id}"
    subnet_id = "${subnet-0e1767c810b88f50e}"
}