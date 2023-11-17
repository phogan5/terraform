variable "profile" {
  type        = string
  description = "the aws profile to use"
  default     = "terraform-user"
}

variable "json_data" {
  description = "the relative file location of a json file containing ddb items"
}