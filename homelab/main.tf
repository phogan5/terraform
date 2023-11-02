terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = "us-east-1"
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
