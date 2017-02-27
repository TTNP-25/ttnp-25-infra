/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "igw01-ttn_infra" {
  vpc_id = "${aws_vpc.ttn_infra.id}"
}

/* Public subnet */
resource "aws_subnet" "public-ttn_infra" {
  vpc_id            = "${aws_vpc.ttn_infra.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.igw01-ttn_infra"]
  tags {
    Name = "public-ttn_infra"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public-rt-ttn_infra" {
  vpc_id = "${aws_vpc.ttn_infra.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw01-ttn_infra.id}"
  }
  tags {
    Name = "route_public_to_igw"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public-rta-ttn_infra" {
  subnet_id = "${aws_subnet.public-ttn_infra.id}"
  route_table_id = "${aws_route_table.public-rt-ttn_infra.id}"
}
