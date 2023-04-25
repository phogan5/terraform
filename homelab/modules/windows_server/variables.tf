variable "sg_id" {
    type = string
    description = "The ID of the security group created for the RHEL and Windows servers"
}

variable "subnet_id" {
    type = string
    description = "The ID of the subnet used when creating the RHEL and Windows servers"
}