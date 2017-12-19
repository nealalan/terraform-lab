# NEAL DREHER
# INSTANCES FILE 20171214
#
# DATA SOURCE FOR RESOURCE AMI NAME
#		data resources let you manage something inside of AWS w/out terraform
data "aws_ami" "ubuntu" {
	most_recent = true
	filter {
			name   = "name"
			values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
	}
	filter {
			name   = "virtualization-type"
			values = ["hvm"]
	}
}
# DEPLOY INSTANCES
#
resource "aws_instance" "neon_aluminum-web-server-1" {
#	ami = "ami-82f4dae7"
	ami = "${data.aws_ami.ubuntu.id}"
	instance_type = "${var.instance_type}"
	subnet_id = "${aws_subnet.neon_aluminum-public-subnet.id}"
	security_groups = ["${aws_security_group.neon_aluminum-open-all.id}"]
	key_name = "${aws_key_pair.neon_aluminum.key_name}"
	tags {
    		Name = "Terraform 02"
	}
}
