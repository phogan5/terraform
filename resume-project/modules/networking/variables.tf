variable "primary_vpc_cidr" {
  description = "Primary CIDR range"
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  default = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  default = "10.0.4.0/24"
}

variable "az1" {
  default = "us-east-1"
}
variable "az2" {
  default = "us-east-2"
}
