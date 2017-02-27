resource "aws_key_pair" "ttn-deployer" {
  key_name = "ttn-deployer-key"
  public_key = "$file(\"${var.ttn_ssh_pub_key}\")"
}
