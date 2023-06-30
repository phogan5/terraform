variable "sg_id" {
    type = string
    description = "The ID of the security group created for the RHEL and Windows servers"
    #secure-vpc default sg
    default = "sg-0054047ff951519f4"
}

variable "subnet_id" {
    type = string
    description = "The ID of the subnet used when creating the RHEL and Windows servers"
    default = "subnet-092a6e9b543ef5ab2"
}

variable "instance_type" {
    type = string
    description = "The size of the EC2 instance"
    default = "t2.micro"
}