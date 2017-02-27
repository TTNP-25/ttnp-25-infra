output "nat.ip" {
  value = "${aws_instance.nat.public_ip}"
}

output "vpc_subnet" {
  value = "${var.vpc_cidr}"
}
