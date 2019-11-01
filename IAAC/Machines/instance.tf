provider "aws" {
  region = "${var.instanceregion}"
}

resource "aws_instance" "appinstance" {
  count                                = "${var.instance_count}"
  ami                                  = "${var.instance_ami}"
  instance_type                        = "${var.instance_type}"
  subnet_id                            = "${var.instance_subnet}"
  associate_public_ip_address               = "${var.auto_instance_public_ip}"
  iam_instance_profile = "${var.instance_role}"
  get_password_data  = "${var.instance_password_data}"
  placement_group = "${var.instance_placement_group}"
  ipv6_address_count = "${var.instance_ipv6_count}"
  ipv6_addresses = "${var.instance_ipv6_addresses}"
  source_dest_check = "${var.instance_source_dest_check}"
  instance_initiated_shutdown_behavior = "${var.instance_shutdown_behavior}"
  disable_api_termination              = "${var.termination_protection}"
  monitoring                           = "${var.instance_monitoring}"
  tenancy                              = "${var.instance_tenancy}"
  user_data                     = "${var.instance_userdata}"
  #availability_zone = "${var.instance_az}"
  key_name = "${var.instance_keyname}"

  vpc_security_group_ids = "${var.instance_vpc_sg_ids}"

  dynamic "root_block_device" {
    for_each = "${var.root_volume}"
    content {
      volume_type = "${lookup(root_block_device.value, "volume_type", null)}"
      volume_size = "${lookup(root_block_device.value, "volume_size", null)}"
      iops = "${lookup(root_block_device.value, "iops", null)}"
      delete_on_termination = "${lookup(root_block_device.value, "delete_on_termination", null)}"
      encrypted = "${lookup(root_block_device.value, "encrypted", null)}"
      kms_key_id = "${lookup(root_block_device.value, "kms_key_id", null)}"
    }
  }

  dynamic "ebs_block_device" {
    for_each = "${var.ebs_volume}"
    content {
      device_name = "${lookup(ebs_block_device.value, "device_name", null)}"
      snapshot_id = "${lookup(ebs_block_device.value, "snapshot_id", null)}"
      volume_type = "${lookup(ebs_block_device.value, "volume_type", null)}"
      volume_size = "${lookup(ebs_block_device.value, "volume_size", null)}"
      iops = "${lookup(ebs_block_device.value, "iops", null)}"
      delete_on_termination = "${lookup(ebs_block_device.value, "delete_on_termination", null)}"
      encrypted = "${lookup(ebs_block_device.value, "encrypted", null)}"
      kms_key_id = "${lookup(ebs_block_device.value, "kms_key_id", null)}"
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = "${var.ephemeral_volume}"
    content {
      device_name = "${lookup(ephemeral_block_device.value, "device_name", null)}"
      virtual_name = "${lookup(ephemeral_block_device.value, "virtual_name", null)}"
      no_device = "${lookup(ephemeral_block_device.value, "no_device", null)}"
    }
  }

  volume_tags = "${merge(map(
    "Name", "${var.instance_name}-Volumes",
    "instance_name", "${var.instance_name}-${count.index+1}",
    ), var.appinstance_volume_tags)}"
  tags = "${merge(map(
    "Name", "${var.instance_name}-${count.index+1}",
    "ami", "${var.instance_ami}",
    ), var.appinstance_tags)}"
}
