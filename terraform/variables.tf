variable "github_organisation" { default = "TTNP-25" }
variable "github_token" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "ttn_vpc_cidr" { default = "10.243.0.0/16" }
variable "ttn_ssh_pub_key" {}
variable "private_subnet_cidr" { default = "10.243.1.0/24" }
variable "public_subnet_cidr" { default = "10.243.2.0/24" }
