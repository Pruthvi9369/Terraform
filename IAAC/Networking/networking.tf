provider "aws" {
  region = "${var.Vpc_provision_region}"
}


resource "aws_vpc" "appvpc" {
  cidr_block = "${var.vpccidr}"
  instance_tenancy = "${var.vpctenancy}"
  enable_dns_support = "${var.dnssupport}"
  enable_dns_hostnames = "${var.dnshostname}"
  enable_classiclink = "${var.vpcclassiclink}"
  #enable_classic_dns_support = "${var.vpcclassiclink_dns}"
  assign_generated_ipv6_cidr_block = "${var.vpccidrblockipv6}"
  tags = "${merge(map(
    "Name", "${var.vpcname}",
    "cidr_block", "${var.vpccidr}",
    ), var.vpc_tags)}"
}

resource "aws_subnet" "apppublicsubnet" {
  count = "${length(var.publicazs)}"
  cidr_block = "${element(var.publicsubnetcidr, count.index)}"
  map_public_ip_on_launch = "${var.publicsubnet_public_ip}"
  availability_zone = "${element(var.publicazs, count.index)}"
  vpc_id = "${aws_vpc.appvpc.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.publicsubnetname}-${count.index+1}",
    "vpc_id", "${aws_vpc.appvpc.id}"
    ), var.publicsubnetname_tags)
  }"
}

resource "aws_subnet" "appprivatesubnet" {
  count = "${length(var.privateazs)}"
  cidr_block = "${element(var.privatesubnetcidr, count.index)}"
  availability_zone = "${element(var.privateazs, count.index)}"
  vpc_id = "${aws_vpc.appvpc.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.privatesubnetname}-${count.index+1}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.privatesubnetname_tags)}"
}

resource "aws_network_acl" "publicnetworkacl" {
  vpc_id = "${aws_vpc.appvpc.id}"
  subnet_ids = "${aws_subnet.apppublicsubnet.*.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.publicnaclname}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.publicnaclname_tags)}"
}

resource "aws_network_acl" "privatenetworkacl" {
  vpc_id = "${aws_vpc.appvpc.id}"
  subnet_ids = "${aws_subnet.appprivatesubnet.*.id}"

  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.privatenaclname}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.privatenaclname_tags)}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.appvpc.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.igwname}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.igwname_tags)}"
}

resource "aws_eip" "natgatewayip" {
  count = "${length(var.publicsubnetcidr)}"
  vpc = true
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.natgatewayeipname}-${count.index+1}",
    "vpc_id", "${aws_vpc.appvpc.id}"
    ), var.igwname_tags)}"
}

resource "aws_nat_gateway" "natgateway" {
  count = "${length(var.publicazs)}"
  allocation_id = "${element(aws_eip.natgatewayip.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.apppublicsubnet.*.id, count.index)}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.natgatewayname}-${count.index+1}",
    "subnet_id", "${element(aws_subnet.apppublicsubnet.*.id, count.index)}",
    ), var.natgatewayname_tags)}"
}

resource "aws_route_table" "publicroutetable" {
  vpc_id = "${aws_vpc.appvpc.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.publicroutetablename}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.publicroutetablename_tags)

  }"
}

resource "aws_route_table_association" "publicrouteassociation" {
  count = "${length(var.publicazs)}"
  subnet_id = "${element(aws_subnet.apppublicsubnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.publicroutetable.id}"
}

resource "aws_route" "publicroute" {
  route_table_id = "${aws_route_table.publicroutetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table" "privateroutetable" {
  vpc_id = "${aws_vpc.appvpc.id}"
  tags = "${merge(map(
    "Name", "${var.vpcname}-${var.privateroutetablename}",
    "vpc_id", "${aws_vpc.appvpc.id}",
    ), var.privateroutetablename_tags)}"
}

resource "aws_route_table_association" "privaterouteassociation" {
  count = "${length(var.privateazs)}"
  subnet_id = "${element(aws_subnet.appprivatesubnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.privateroutetable.id}"
}

resource "aws_route" "privateroute" {
  count = "${length(aws_nat_gateway.natgateway)}"
  route_table_id = "${aws_route_table.privateroutetable.id}"
  destination_cidr_block = "${element(split(",",var.privateroutefornatgateway), count.index)}"
  nat_gateway_id = "${element(aws_nat_gateway.natgateway.*.id,count.index)}"
}

resource "aws_network_acl_rule" "publicnetworkacl_inbound" {
  count = "${length(var.publicNACL_inbound)}"
  network_acl_id = "${aws_network_acl.publicnetworkacl.id}"
  egress = false
  rule_number = "${var.publicNACL_inbound[count.index]["rule_number"]}"
  rule_action = "${var.publicNACL_inbound[count.index]["rule_action"]}"
  from_port = "${lookup(var.publicNACL_inbound[count.index], "from_port", null)}"
  to_port = "${lookup(var.publicNACL_inbound[count.index], "to_port", null)}"
  icmp_code = "${lookup(var.publicNACL_inbound[count.index], "icmp_code", null)}"
  icmp_type = "${lookup(var.publicNACL_inbound[count.index], "icmp_type", null)}"
  protocol = "${var.publicNACL_inbound[count.index]["protocol"]}"
  cidr_block = "${lookup(var.publicNACL_inbound[count.index], "cidr_block", null)}"
  ipv6_cidr_block = "${lookup(var.publicNACL_inbound[count.index], "ipv6_cidr_block", null)}"
}

resource "aws_network_acl_rule" "publicnetworkacl_outbound" {
  count = "${length(var.publicNACL_outbound)}"
  network_acl_id = "${aws_network_acl.publicnetworkacl.id}"
  egress = true
  rule_number = "${var.publicNACL_outbound[count.index]["rule_number"]}"
  rule_action = "${var.publicNACL_outbound[count.index]["rule_action"]}"
  from_port = "${lookup(var.publicNACL_outbound[count.index], "from_port", null)}"
  to_port = "${lookup(var.publicNACL_outbound[count.index], "to_port", null)}"
  icmp_code = "${lookup(var.publicNACL_outbound[count.index], "icmp_code", null)}"
  icmp_type = "${lookup(var.publicNACL_outbound[count.index], "icmp_type", null)}"
  protocol = "${var.publicNACL_outbound[count.index]["protocol"]}"
  cidr_block = "${lookup(var.publicNACL_outbound[count.index], "cidr_block", null)}"
  ipv6_cidr_block = "${lookup(var.publicNACL_outbound[count.index], "ipv6_cidr_block", null)}"
}

resource "aws_network_acl_rule" "privatenetworkacl_inbound" {
  count = "${length(var.privateNACL_inbound)}"
  network_acl_id = "${aws_network_acl.privatenetworkacl.id}"
  egress = false
  rule_number = "${var.privateNACL_inbound[count.index]["rule_number"]}"
  rule_action = "${var.privateNACL_inbound[count.index]["rule_action"]}"
  from_port = "${lookup(var.privateNACL_inbound[count.index], "from_port", null)}"
  to_port = "${lookup(var.privateNACL_inbound[count.index], "to_port", null)}"
  icmp_code = "${lookup(var.privateNACL_inbound[count.index], "icmp_code", null)}"
  icmp_type = "${lookup(var.privateNACL_inbound[count.index], "icmp_type", null)}"
  protocol = "${var.privateNACL_inbound[count.index]["protocol"]}"
  cidr_block = "${lookup(var.privateNACL_inbound[count.index], "cidr_block", null)}"
  ipv6_cidr_block = "${lookup(var.privateNACL_inbound[count.index], "ipv6_cidr_block", null)}"
}

resource "aws_network_acl_rule" "privatenetworkacl_outbound" {
  count = "${length(var.privateNACL_outbound)}"
  network_acl_id = "${aws_network_acl.privatenetworkacl.id}"
  egress = true
  rule_number = "${var.privateNACL_outbound[count.index]["rule_number"]}"
  rule_action = "${var.privateNACL_outbound[count.index]["rule_action"]}"
  from_port = "${lookup(var.privateNACL_outbound[count.index], "from_port", null)}"
  to_port = "${lookup(var.privateNACL_outbound[count.index], "to_port", null)}"
  icmp_code = "${lookup(var.privateNACL_outbound[count.index], "icmp_code", null)}"
  icmp_type = "${lookup(var.privateNACL_outbound[count.index], "icmp_type", null)}"
  protocol = "${var.privateNACL_outbound[count.index]["protocol"]}"
  cidr_block = "${lookup(var.privateNACL_outbound[count.index], "cidr_block", null)}"
  ipv6_cidr_block = "${lookup(var.privateNACL_outbound[count.index], "ipv6_cidr_block", null)}"
}
