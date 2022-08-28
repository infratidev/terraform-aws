#############################################
#Creating Virtual Private Cloud:
#############################################

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.custom_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#############################################
# Creating Private subnet:
#############################################

resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnets_cidr)
  vpc_id                  = aws_vpc.custom_vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = element(var.private_subnets_cidr, count.index)
  map_public_ip_on_launch = false 

  tags = {
    "Name" = "Private-Subnet-${count.index}"
  }
}

#############################################
# Creating Public subnet:
#############################################

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.custom_vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = element(var.public_subnets_cidr, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    "Name" = "Public-Subnet-${count.index}"
  }
}

#############################################
# Creating Internet Gateway:
#############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    "Name" = "Internet-Gateway"
  }
}

#############################################
# Creating Nat Gateway:
#############################################

resource "aws_nat_gateway" "ngw" {
  depends_on     = [aws_eip.eip]
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id  = element(aws_eip.eip.*.id, count.index)

  tags = {
    "Name" = "Nat-Gateway-${count.index}"
  }
}

#############################################
# Creating Public Route Table:
#############################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    "Name" = "Public-RouteTable"
  }
}

#############################################
# Creating Private Route Table:
#############################################

resource "aws_route_table" "private_rt" {
  depends_on = [aws_nat_gateway.ngw]
  count      = length(var.private_subnets_cidr)
  vpc_id     = aws_vpc.custom_vpc.id

  tags = {
    "Name" = "Private-RouteTable-${count.index}"
  }
}

#############################################
# Creating Public Route:
#############################################

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#############################################
# Creating Private Route:
#############################################

resource "aws_route" "private_route" {
  count                  = length(var.private_subnets_cidr)
  route_table_id         = element(aws_route_table.private_rt.*.id,count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_nat_gateway.ngw.*.id,count.index)
}

#############################################
# Creating Private Route Table Association:
#############################################

resource "aws_route_table_association" "private_rt_association" {
  depends_on     = [aws_route_table.private_rt]
  count          = length(var.private_subnets_cidr)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
}

#############################################
# Creating Public Route Table Association:
#############################################

resource "aws_route_table_association" "public_rt_association" {
  depends_on     = [aws_route_table.public_rt]
  count          = length(var.public_subnets_cidr)
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}

############################################################################################
# Creating 1 Elastic IPs:
############################################################################################

resource "aws_eip" "eip" {
  count            = length(var.public_subnets_cidr)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP"
  }
}

