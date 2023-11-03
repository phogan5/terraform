variable "vpc_cidr" {
  type        = string
  description = "vpc cidr range"
}

variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}
