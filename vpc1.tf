# Checking AWS availability Zones 
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating VPC 
resource "aws_vpc" "vpc1" {
  cidr_block = var.cidr_range
  tags = {
    Name = var.vpc_name
  }
}

# Creating IGW 
resource "aws_internet_gateway" "my-IGW" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = var.igw_name
  }
}

# Creating Public Route Table 
resource "aws_route_table" "my-route1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-IGW.id 
  }
  tags = {
    Name = var.public_route_name
  }  
}

# Creating Public Subnets 
resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.cidr_range_for_public_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = var.name_for_public_subnet[count.index]
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.my-route1.id
}

# Creating Private Subnets 
resource "aws_subnet" "private_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.cidr_range_for_private_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = var.name_for_private_subnet[count.index]
  }
}




