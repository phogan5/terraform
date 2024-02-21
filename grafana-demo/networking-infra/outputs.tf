output "vpc_id" {
  value = aws_vpc.main.id
}

output "k8s-az1" {
  value = aws_subnet.k8s-az1
}

output "k8s-az2" {
  value = aws_subnet.k8s-az2
}

output "k8s-controller" {
  value = aws_subnet.k8s-controller
}

output "k8s-az1-reserved" {
  value = aws_subnet.k8s-az1-reserved
}

output "k8s-az2-reserved" {
  value = aws_subnet.k8s-az2-reserved
}