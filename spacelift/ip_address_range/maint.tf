provider "spacelift" {}

terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}


data "spacelift_ips" "ips" {}