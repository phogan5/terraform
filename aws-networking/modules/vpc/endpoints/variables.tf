variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}

variable "subnet-app-1a" {}
variable "subnet-app-1b" {}
variable "subnet-app-1c" {}

variable "subnet-db-1a" {}
variable "subnet-db-1b" {}
variable "subnet-db-1c" {}

variable "vpc_id" {
  type = string
}

variable "natgw-1-rt" {}
variable "natgw-2-rt" {}
variable "natgw-3-rt" {}

