variable "sg_name" {
  type = "string"
  default = "new_sg"
}

variable "assign_vpc_id" {
  type = "string"
  default = "vpc-098b4739cdfffa7ca"
}

variable "instance_sg_ingress" {
  type = list(map(string))
  default = [
    {
      from_port = "80"
      to_port = "80"
      protocol = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "instance_sg_egress" {
  type = list(map(string))
  default = [
    {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "instance_sg_tags" {
  description = "Please provide tags to sg"
  type = map
  default = {}
}
