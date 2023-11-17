output "ec2_profile" {
  value       = aws_iam_instance_profile.ec2_profile.name
  sensitive   = false
  description = "the ec2 instance profile created"
}

output "flow_log_role" {
  value = aws_iam_role.flow_logs_role
  sensitive = false
  description = "the iam role granting permissions for vpc flow logging"
}
