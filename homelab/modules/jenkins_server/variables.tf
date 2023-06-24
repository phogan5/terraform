variable "sg_id" {
    default = "sg-0ef14fe8850f5e75a"
    type = string
    description = "The ID of the security group created for the RHEL and Windows servers"
}

variable "subnet_id" {
    default = "subnet-0e1767c810b88f50e"
    type = string
    description = "The ID of the subnet used when creating the RHEL and Windows servers"
}