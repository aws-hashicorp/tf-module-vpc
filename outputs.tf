output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.*.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet.*.id
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets"
  value       = aws_subnet.database_subnet.*.id
}

output "transit_gateway_attachment_status" {
  description = "The status of the Transit Gateway attachment"
  value       = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment.*.state
}
