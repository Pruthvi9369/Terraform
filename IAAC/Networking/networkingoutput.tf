output "vpc_arn" {
  description = "VPC ARN output"
  value = aws_vpc.appvpc.arn
}

output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.appvpc.id
}

output "vpc_cidrblock" {
  description = "VPC CIDR Range"
  value = aws_vpc.appvpc.cidr_block
}

output "vpc_instance_tenancy" {
  description = "VPC Instance Tenancy"
  value = aws_vpc.appvpc.instance_tenancy
}

output "vpc_enable_dns_support" {
  description = "VPC Enabled DNS Support"
  value = aws_vpc.appvpc.enable_dns_support
}

output "vpc_main_route_table_id" {
  description = "VPC Main Route table id"
  value = aws_vpc.appvpc.main_route_table_id
}

output "vpc_default_network_acl_id" {
  description = "VPC Default Network ACL ID"
  value = aws_vpc.appvpc.default_network_acl_id
}

output "vpc_default_security_group_id" {
  description = "VPC Default Security Group ID"
  value = aws_vpc.appvpc.default_security_group_id
}

output "vpc_owner_id" {
  description = "VPC Owner Id"
  value = aws_vpc.appvpc.owner_id
}

output "vpc_public_subnet_ids" {
  description = "VPC Public Subnet IDs"
  value = aws_subnet.apppublicsubnet.*.id
}

output "vpc_private_subnet_ids" {
  description = "VPC Public Subnet IDs"
  value = aws_subnet.appprivatesubnet.*.id
}

output "vpc_public_nacl_subnet_ids" {
  description = "VPC Public Subnet IDs"
  value = aws_network_acl.publicnetworkacl.id
}

output "vpc_private_nacl_subnet_ids" {
  description = "VPC Public Subnet IDs"
  value = aws_network_acl.privatenetworkacl.id
}

output "vpc_internet_gateway_id" {
  description = "VPC Internet gateway id"
  value = aws_internet_gateway.igw.id
}

output "vpc_eip_ids" {
  description = "Elastic Ip's id for Natgateway"
  value = aws_eip.natgatewayip.*.id
}

output "vpc_aws_nat_gateway" {
  description = "AWS Nat Gateways"
  value = aws_nat_gateway.natgateway.*.id
}

output "vpc_public_route_table" {
  description = "VPC Public Route Table"
  value = aws_route_table.publicroutetable.id
}

output "vpc_private_route_table" {
  description = "VPC Private route table"
  value = aws_route_table.privateroutetable.id
}
