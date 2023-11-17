output "vpc_id" {
  value       = aws_vpc.a4l-vpc1.id
  sensitive   = false
  description = "description"
}



output "web_sg" {
  value       = aws_security_group.web_sg.id
  sensitive   = false
  description = "access to web servers"
}
