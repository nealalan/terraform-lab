# Part 2 Creating a Resource
# https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#LaunchInstanceWizard:
# PART 3.1 VPC
#   Create a VPC resource for our subnets
resource "aws_vpc" "neon_aluminum-vpc" {
	cidr_block = "10.0.0.0/16"
	tags {
    		Name = "NeAl VPC"
				management = "terraform"
	}
}
# PART 3.2.1 INTERNET GATEWAY
#   Create an internet gateway resource definition
resource "aws_internet_gateway" "neon_aluminum-ig" {
  	vpc_id = "${aws_vpc.neon_aluminum-vpc.id}",
  	tags {
      	Name = "NeAl Inet Gateway"
				management = "terraform"
  	}
}
# PART 3.2.2 ACL
#   Internet gateway specific security rules Access Control List ACL Stateless
resource "aws_network_acl" "neon_aluminum-acl" {
	vpc_id = "${aws_vpc.neon_aluminum-vpc.id}"
	tags {
    		Name = "NeAl ACL"
				management = "terraform"
	}
}
# PART 3.2.3 ACL RULES
#   For an ACL to be effective it needs to have rules
resource "aws_network_acl_rule" "neon_aluminum-acl-rule" {
	network_acl_id = "${aws_network_acl.neon_aluminum-acl.id}"
	rule_number = 100
	egress = false
	protocol = "-1"
	rule_action = "allow"
	cidr_block = "0.0.0.0/0"
	from_port = 0
	to_port = 65535
}
# PART 3.4 SUBNETS
#   Create a subnet that will hold all public instances.
resource "aws_subnet" "neon_aluminum-public-subnet" {
  	vpc_id = "${aws_vpc.neon_aluminum-vpc.id}"
  	cidr_block = "10.0.1.0/24"
  	#availability_zone = "${var.availability_zone}"
  	map_public_ip_on_launch = true
  	tags {
      	Name = "NeAl Public Subnet"
				management = "terraform"
  	}
}
resource "aws_subnet" "neon_aluminum-private-subnet" {
  	vpc_id = "${aws_vpc.neon_aluminum-vpc.id}"
  	cidr_block = "10.0.10.0/24"
  	#availability_zone = "${var.availability_zone}"
  	map_public_ip_on_launch = false
  	tags {
      	Name = "NeAl Private Subnet"
				management = "terraform"
  	}
}
# PART 3.5.1 ROUTING TABLE
#   Create a routing table to serve as public route table
resource "aws_route_table" "neon_aluminum-rt-public" {
  	vpc_id            = "${aws_vpc.neon_aluminum-vpc.id}"
}
# PART 3.5.2 ROUTE
#   Create a public route to allow the subnet to route to the internet
resource "aws_route" "neon_aluminum-rt-public-to-internet" {
	route_table_id           = "${aws_route_table.neon_aluminum-rt-public.id}"
	destination_cidr_block   = "0.0.0.0/0"
	gateway_id               = "${aws_internet_gateway.neon_aluminum-ig.id}"
}
# PART 3.5.3 ROUTE TABLE ASSOCIATION
#   Create a route table to attach the public route table to the public subnet.
resource "aws_route_table_association" "public" {
	subnet_id            = "${aws_subnet.neon_aluminum-public-subnet.id}"
	route_table_id       = "${aws_route_table.neon_aluminum-rt-public.id}"
}
