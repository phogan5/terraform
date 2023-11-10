output vpc_id {
  value       = aws_vpc.a4l-vpc1.id
  sensitive   = false
  description = "description"
}

output subnet-app-1a {
    value = aws_subnet.sn-app-1a.id
    sensitive = false
    description = "the subnet id of subnet app-1a"
}
