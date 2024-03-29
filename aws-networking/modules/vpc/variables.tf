variable "vpc_cidr" {
  type        = string
  description = "vpc cidr range"
  default     = "10.16.0.0/16"
}

variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}

