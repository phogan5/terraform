variable "port_number" {
  description = "the tcp port to open the web server to"
  type = number
  default = "8080"
}

variable "cluster_name"{
  description = "The name to use for all resources within a cluster"
  type = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the databases remote state"
  type = string
}

variable "db_remote_state_key"{
  description = "The path for the databases remote state in s3"
  type = string
}