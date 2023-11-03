terraform {
    source = "../../../modules/vpc"
}

inputs = {
    vpc_cidr = "10.16.0.0/16"
    profile = "terraform-user"
}