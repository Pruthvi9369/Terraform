variable "Vpc_provision_region" {
  type = "string"
  default = "us-east-2"
}

variable "vpccidr" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "vpctenancy" {
  type = "string"
  default = "default"
}

variable "dnssupport" {
  type = bool
  default = "true"
}

variable "dnshostname" {
  type = bool
  default = "true"
}

variable "vpcclassiclink" {
  type = bool
  default = "false"
}

variable "vpcclassiclink_dns" {
  type = bool
  default = "false"
}

variable "vpccidrblockipv6" {
  type = bool
  default = "false"
}

variable "vpcname" {
  type = "string"
  default = "Test_Vpc"
}

# Note: Please provide multiple availability_zone if you are creating multiple subnets
variable "publicazs" {
  type = "list"
  default = ["us-east-2a","us-east-2b"]
}

# Note: Please provide multiple subnet cidr if you are creating multiple subnets
variable "publicsubnetcidr" {
  type = "list"
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "publicsubnet_public_ip" {
  type = bool
  default = true
}

variable "publicsubnetname" {
  type = "string"
  default = "Test_VPC_Subnet_Public"
}

# Note: Please provide multiple availability_zone if you are creating multiple subnets
variable "privateazs" {
  type = "list"
  default = ["us-east-2c"]
}

# Note: Please provide multiple subnet cidr if you are creating multiple subnets
variable "privatesubnetcidr" {
  type = "list"
  default = ["10.0.3.0/24"]
}

variable "privatesubnetname" {
  type = "string"
  default = "Test_VPC_Subnet_Private"
}

variable "publicnaclname" {
  type = "string"
  default = "Test_VPC_Public_NACL"
}

variable "privatenaclname" {
  type = "string"
  default = "Test_VPC_Private_NACL"
}

variable "igwname" {
  type = "string"
  default = "Test_VPC_IGW"
}

variable "natgatewayeipname" {
  type = "string"
  default = "Test_VPC_Natgateway_ipname"
}

variable "natgatewayname" {
  type = "string"
  default = "Test_VPC_Natgateway_name"
}

variable "publicroutetablename" {
  type = "string"
  default = "Test_VPC_Public_RouteTable"
}

variable "privateroutetablename" {
  type = "string"
  default = "Test_VPC_Private_RouteTable"
}

variable "publicNACL_inbound" {
  description = "Public NACL Inboud Rules"
  type = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port = "22"
      to_port = "22"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      rule_number = 101
      rule_action = "allow"
      from_port = "3306"
      to_port = "3306"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "publicNACL_outbound" {
  description = "Public NACL Inboud Rules"
  type = list(map(string))

  default = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
      },
      {
        rule_number = 101
        rule_action = "allow"
        from_port = "3306"
        to_port = "3306"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
      }
  ]
}

variable "privateNACL_inbound" {
  description = "Private NACL Inboud Rules"
  type = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "privateNACL_outbound" {
  description = "Private NACL Outbound Rules"
  type = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

# Note: If you are creating multiple public subnets, it creats multiple Nat Gateways
#       so please provide multiple strings saparated with comma ex: "0.0.0.0/0,0.0.0.0/1"
#       if you don't provide those it may throw error
variable "privateroutefornatgateway" {
  type = "string"
  default = "0.0.0.0/0,0.0.0.0/1"
}
