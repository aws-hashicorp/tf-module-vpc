output "vpc_id" {
  description = "The ID of the VPC"
  value       = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet.*.id
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets"
  value       = aws_subnet.database_subnet.*.id
}
