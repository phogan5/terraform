variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}

variable "ami" {
  type        = string
  description = "the ec2 ami to use"
  default     = "ami-0e8a34246278c21e4"
}

variable "vpc_id" {
  type        = string
  description = "the vpc id"
}

variable "subnet-web-1a" {
  type        = string
  description = "subnet id of subnet web-1a"
}

variable "subnet-app-1a" {
  type        = string
  description = "subnet id of subnet app-1a"
}

variable "ec2_profile" {
  type        = string
  description = "the ec2 instance profile created"
}

variable "web_sg" {
  type        = string
  description = "access to web servers"
}