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
variable "sn-reserved-1a" {}
variable "sn-reserved-1b" {}
variable "sn-reserved-1c" {}

variable "sn-db-1a" {}
variable "sn-db-1b" {}
variable "sn-db-1c" {}

variable "sn-app-1a" {}
variable "sn-app-1b" {}
variable "sn-app-1c" {}

variable "sn-web-1a" {}
variable "sn-web-1b" {}
variable "sn-web-1c" {}
