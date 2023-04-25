provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "remote_datastore" {
    identifier_prefix = "homelab-data-store"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    skip_final_snapshot = true
    db_name = "homelab_data_store"

    #Creds
    username = var.db_username
    password = var.db_password
  
}