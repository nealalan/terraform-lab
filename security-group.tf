# PART 3.3.1 SECURITY GROUPS
resource "aws_security_group" "neon_aluminum-open-all" {
	vpc_id = "${aws_vpc.neon_aluminum-vpc.id}"
}
# PART 3.3.2
#   Create a rule definition for the SG that allows all incoming TCP traffic.
resource "aws_security_group_rule" "open-all-inbound" {
	type = "ingress"
	from_port = 0
	to_port = 65535
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.neon_aluminum-open-all.id}"
}
#   Create a rule definition for the SG that allows all incoming ICMP traffic.
resource "aws_security_group_rule" "open-all-in-icmp" {
	type = "ingress"
	from_port = 8
	to_port = 0
	protocol = "icmp"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.neon_aluminum-open-all.id}"
}
#   Create a rule definiton for the SG that allows all outgoing traffic
resource "aws_security_group_rule" "open-all-out" {
	type = "egress"
	from_port = 0
	to_port = 65535
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.neon_aluminum-open-all.id}"
}
