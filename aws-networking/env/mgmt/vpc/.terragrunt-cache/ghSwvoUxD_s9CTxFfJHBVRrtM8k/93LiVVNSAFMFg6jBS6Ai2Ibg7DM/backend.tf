# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "phogan-tf-state"
    key            = "modules/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
