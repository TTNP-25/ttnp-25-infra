/* Default security group */
resource "aws_security_group" "default" {
  name = "default-ttn_infra"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.ttn_infra.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ttn_infra-default-securitygroup"
  }
}

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "nat-ttn_infra"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.ttn_infra.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.235.1.0/24"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.235.1.0/24"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags {
    Name = "nat-ttn_infra"
  }
}

/* Security group for the RDS MySQL nodes */
resource "aws_security_group" "rds" {
  name = "mysql-ttn_infra"
  description = "MySQL RDS"
  vpc_id = "${aws_vpc.ttn_infra.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
    self = true
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "rds-ttn_infra" 
  }
}

/* Security group for the web nodes */
resource "aws_security_group" "web" {
  name = "web-ttn_infra"
  description = "Web Nodes"
  vpc_id = "${aws_vpc.ttn_infra.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 5555
    to_port   = 5555
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "web-ttn_infra" 
  }
}

/* Security group for the Load Balancers */
resource "aws_security_group" "elb_access" {
  name = "elb_access-ttn_infra"
  description = "Security group for ELBs that allows web traffic from internet"
  vpc_id = "${aws_vpc.ttn_infra.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "elb_access-ttn_infra" 
  }
}
