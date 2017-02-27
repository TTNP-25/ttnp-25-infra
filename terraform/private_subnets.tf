/* Private subnet */
resource "aws_subnet" "private-ttn_infra" {
  vpc_id            = "${aws_vpc.ttn_infra.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.nat"] 
  tags {
    Name = "private-ttn_infra"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private-rt-ttn_infra" {
  vpc_id = "${aws_vpc.ttn_infra.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
  tags {
    Name = "private-to-public"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "ttn_infra-rta-private" {
  subnet_id = "${aws_subnet.private-ttn_infra.id}"
  route_table_id = "${aws_route_table.private-rt-ttn_infra.id}"
}
