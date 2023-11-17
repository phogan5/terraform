output "web_sg" {
  value       = aws_security_group.web_sg.id
  sensitive   = false
  description = "access to web servers"
}