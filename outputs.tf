output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "ARN of the VPC."
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Map of public subnet names to subnet IDs."
  value       = { for name, subnet in aws_subnet.public : name => subnet.id }
}

output "internet_gateway_id" {
  description = "ID of the internet gateway, if created."
  value       = try(aws_internet_gateway.this[0].id, null)
}

output "public_route_table_id" {
  description = "ID of the public route table, if created."
  value       = try(aws_route_table.public[0].id, null)
}

output "security_group_id" {
  description = "ID of the managed security group, if created."
  value       = try(aws_security_group.this[0].id, null)
}
