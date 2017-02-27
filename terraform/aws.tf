# Configure the AWS Provider
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "eu-west-1"
}

resource "aws_vpc" "ttn_infra" {
    cidr_block = "${var.ttn_vpc_cidr}"

    tags {
        Name = "ttn_infra"
    }
}


