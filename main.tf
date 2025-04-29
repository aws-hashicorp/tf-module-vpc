/**
	* @description: This module creates a VPC with private subnets and a route table.
	* @module: vpc
	**/

resource "aws_vpc" "vpc" {

  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.name}"
  }

}

resource "aws_subnet" "private_subnet" {

  count                   = var.create_private_subnet ? length(var.private_subnet_cidr_block) : 0
  vpc_id                  = aws_vpc.vpc[0].id
  cidr_block              = element(var.private_subnet_cidr_block, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${var.name}-${[for az in var.availability_zones : split("-", az)[2]][count.index]}"
  }

}

resource "aws_route_table" "private_route_table" {

  count  = var.create_private_subnet ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id
  tags   = { Name = "private-route-table-${var.name}" }

}

resource "aws_route" "allow_all_outbound" {

  count                  = var.create_transit_gateway_attachment ? 1 : 0
  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id

  timeouts {
    create = "2m"
    update = "2m"
  }
  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attachment]

  lifecycle {
    ignore_changes = [transit_gateway_id]
  }

}


resource "aws_route_table_association" "private_route_table_association" {

  count          = var.create_private_subnet ? length(var.private_subnet_cidr_block) : 0
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id

}

resource "aws_subnet" "database_subnet" {

  count                   = var.create_database_subnet ? length(var.database_subnet_cidr_block) : 0
  vpc_id                  = aws_vpc.vpc[0].id
  cidr_block              = element(var.database_subnet_cidr_block, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
  Name = "database-subnet-${var.name}-${[for az in var.availability_zones : split("-", az)[2]][count.index]}" }

}

resource "aws_route_table" "database_route_table" {

  count  = var.create_database_subnet ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id
  tags   = { Name = "database-route-table-${var.name}" }

}

resource "aws_route_table_association" "database_route_table_association" {

  count          = var.create_database_subnet ? length(var.database_subnet_cidr_block) : 0
  subnet_id      = aws_subnet.database_subnet[count.index].id
  route_table_id = aws_route_table.database_route_table[count.index].id

}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {

  count              = var.create_transit_gateway_attachment ? 1 : 0
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = aws_vpc.vpc[0].id
  subnet_ids         = [for subnet in aws_subnet.private_subnet : subnet.id]

  tags = {
    Name = "tgw-attachment-${var.name}"
  }

}
