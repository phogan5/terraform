variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}

variable "vpc_id" {
  type        = string
  description = "the working vpc"
}