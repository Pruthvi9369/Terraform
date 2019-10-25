variable "instanceregion" {
  type    = "string"
  default = "us-east-1"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_ami" {
  type    = "string"
  default = "ami-00eb20669e0990cb4"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}

#variable "instance_vpc" {
#  type    = "string"
#  default = "vpc-098b4739cdfffa7ca"
#}

variable "instance_subnet" {
  type    = "string"
  default = "subnet-0508810222f7402b9"
}

# Note: Please provide or select
variable "auto_instance_public_ip" {
  type    = "string"
  default = "false"
}

variable "instance_role" {
  type    = "string"
  default = ""
}

variable "instance_password_data" {
  type = "string"
  default = "false"
}

variable "instance_placement_group" {
  type = "string"
  default = ""
}

variable "instance_ipv6_count" {
  type = "string"
  default = "0"
}

variable "instance_ipv6_addresses" {
  type = list
  default = []
}

variable "instance_source_dest_check" {
  type = "string"
  default = "false"
}

variable "instance_shutdown_behavior" {
  type    = "string"
  default = "stop"
}

variable "termination_protection" {
  type    = "string"
  default = "false"
}

variable "instance_monitoring" {
  type    = "string"
  default = "false"
}

variable "instance_tenancy" {
  type    = "string"
  default = "default"
}

variable "instance_userdata" {
  type    = "string"
  default = <<-EOT
    echo "Hallo World"
    EOT
}

#variable "instance_az" {
#  type = "stirng"
#  default = ""
#}

variable "root_volume" {
  type = list(map(string))
  default = [
    {
      volume_type = "gp2"
      volume_size = "8"
      iops = "0"
      delete_on_termination = "true"
      encrypted = "false"
      kms_key_id = ""
    }
  ]
}

variable "ebs_volume" {
  type = list(map(string))
  default = [
#    {
#      device_name = "/dev/sdb"
#      snapshot_id = ""
#      volume_type = "gp2"
#      volume_size = "8"
#      iops = "0"
#      delete_on_termination = "true"
#      encrypted = "false"
#      kms_key_id = ""
#    },
#    {
#      device_name = "/dev/sdc"
#      snapshot_id = ""
#      volume_type = "gp2"
#      volume_size = "8"
#      iops = "0"
#      delete_on_termination = "true"
#      encrypted = "false"
#      kms_key_id = ""
#    }
  ]
}

variable "ephemeral_volume" {
  type = list(map(string))
  default = []
}

variable "instance_name" {
  type    = "string"
  default = "TestApp1"
}

variable "instance_keyname" {
  type = "string"
  default = "linux_key"
}

variable "instance_vpc_sg_ids" {
  type = list
  default = ["sg-0f2285ec2dbcee3af", "sg-0fbfb800ce419f176"]
}
