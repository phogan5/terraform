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
    source = "./data_stores"
}

module "homelab_network" {
    source = "./modules/network"

    vpc_id = "vpc-08b6a277deb2d6942"
}

module "linux_server" {
    source = "./modules/linux_server"

    sg_id = "${module.homelab_network.sg_id}"
    subnet_id = "subnet-0e1767c810b88f50e"
}

module "windows_server" {
    source = "./modules/windows_server"

    sg_id = "${module.homelab_network.sg_id}"
    subnet_id = "subnet-0e1767c810b88f50e"
}