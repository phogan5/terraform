terraform {
  cloud {
    organization = "example-org-4de848"

    workspaces {
      name = "homelab"
    }
  }

  required_version = ">= 1.1.2"
}
