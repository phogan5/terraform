output "vpc_id" {
  value       = aws_vpc.a4l-vpc1.id
  sensitive   = false
  description = "description"
}

output "subnet-web-1a" {
  value       = aws_subnet.sn-web-1a.id
  sensitive   = false
  description = "the subnet id of subnet web-1a"
}

output "subnet-app-1a" {
  value       = aws_subnet.sn-app-1a.id
  sensitive   = false
  description = "the subnet id of subnet app-1a"
}

output "web_sg" {
  value       = aws_security_group.web_sg.id
  sensitive   = false
  description = "access to web servers"
}
