variable "sg_id" {
    type = string
    description = "The ID of the security group created for the RHEL and Windows servers"
    #secure-vpc default sg
    default = "sg-077719556036cf09f"
}

variable "subnet_id" {
    type = string
    description = "The ID of the subnet used when creating the RHEL and Windows servers"
    default = "	subnet-0ff14dab42cc0ed49"
}

variable "vpc_id" {
    type = string
    default = "vpc-0a97ebce69d66ec31"
  
}

variable "instance_type" {
    type = string
    description = "The size of the EC2 instance"
    default = "t2.micro"
}