resource "aws_security_group" "instance_sg" {
  name = "${var.sg_name}"
  vpc_id = "${var.assign_vpc_id}"

  dynamic "ingress" {
    for_each = "${var.instance_sg_ingress}"
    content {
      from_port = "${lookup(ingress.value, "from_port", null)}"
      to_port = "${lookup(ingress.value, "to_port", null)}"
      protocol = "${lookup(ingress.value, "protocol", null)}"
      cidr_blocks = ["${lookup(ingress.value, "cidr_blocks", null)}"]
    }

  }

  dynamic "egress" {
    for_each = "${var.instance_sg_egress}"
    content {
      from_port = "${lookup(egress.value, "from_port", null)}"
      to_port = "${lookup(egress.value, "to_port", null)}"
      protocol = "${lookup(egress.value, "protocol", null)}"
      cidr_blocks = ["${lookup(egress.value, "cidr_blocks", null)}"]
      #prefix_list_ids = ["${lookup(egress.value, "prefix_list_ids", null)}"]
    }
  }

  tags = "${merge(map(
    "Name", "${var.sg_name}",
    "vpc_id", "${var.assign_vpc_id}",
    ), var.instance_sg_tags)}"

}
