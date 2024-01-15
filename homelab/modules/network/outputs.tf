output "sg_id" {
    value = "${aws_security_group.homelab-sg.id}"
}

output "vpc_id" {
    value = aws_vpc.secure_vpc.id
}


