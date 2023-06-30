output "public_ip" {
  value = aws_eip.tf_eip.address
}