variable "aws_access_key" { }
variable "aws_secret_key" { }
# PART 3.6 SSH KEY PAIRS
#   Use Terraform to give AWS the SSH Keys we will be using.
#   ./.ssh/
# USE:
#   $ ssh-keygen -t rsa -b 4096 -C "neal@neonaluminum.com"
resource "aws_key_pair" "neon_aluminum" {
  	key_name = "neon_aluminum"
  	public_key = "${file("./.ssh/neon_aluminum01.pub")}"
}
