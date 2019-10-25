output "instance_ids" {
  description = "ec2 instances ids"
  value = aws_instance.appinstance.*.id
}

output "instance_arn" {
  description = "ec2 instance arn's"
  value = aws_instance.appinstance.*.arn
}

output "instance_az" {
  description = "instance az's"
  value = aws_instance.appinstance.*.availability_zone
}

output "instance_placement_group" {
  description = "instanc placment groups"
  value = aws_instance.appinstance.*.placement_group
}

output "instance_keyname" {
  description = "instance key pair"
  value = aws_instance.appinstance.*.key_name
}

output "instance_password_data" {
  description = "windows instance password data"
  value = aws_instance.appinstance.*.password_data
}

output "instance_public_dns" {
  description = "instance public dns"
  value = aws_instance.appinstance.*.public_dns
}

output "instance_public_ip" {
  description = "instance public dns"
  value = aws_instance.appinstance.*.public_ip
}

output "instance_ipv6_addresses" {
  description = "instance ipv6 addresses"
  value = aws_instance.appinstance.*.ipv6_addresses
}

output "instance_primary_network_interface_id" {
  description = "instance primary network interface id"
  value = aws_instance.appinstance.*.primary_network_interface_id
}

output "instance_private_dns" {
  description = "Instance private DNS details"
  value = aws_instance.appinstance.*.private_dns
}

output "instance_private_ip" {
  description = "Instance private DNS details"
  value = aws_instance.appinstance.*.private_ip
}

output "instance_sg" {
  description = "Instance security groups"
  value = aws_instance.appinstance.*.security_groups
}

output "instance_vpc_sg" {
  description = "Instance vpc's security groups"
  value = aws_instance.appinstance.*.vpc_security_group_ids
}

output "instance_subnet_id" {
  description = "Instance vpc's security groups"
  value = aws_instance.appinstance.*.subnet_id
}

output "instance_state" {
  description = "Instance status"
  value = aws_instance.appinstance.*.instance_state
}
