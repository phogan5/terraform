output ec2_profile {
  value       = aws_iam_instance_profile.ec2_profile.name
  sensitive   = false
  description = "the ec2 instance profile created"
}
