provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_ec2_instance_connect_endpoint" "db_subnet_instance_connect_endpoint" {
  subnet_id = var.subnet-db-1a

  tags = {
    Name = "db-1a"
  }
}

resource "aws_vpc_endpoint" "ddb_gateway_endpoint" {
  vpc_id = var.vpc_id
  service_name = "com.amazonaws.us-east-1.dynamodb"
  route_table_ids = [var.natgw-1-rt.id, var.natgw-2-rt.id, var.natgw-3-rt.id]

}