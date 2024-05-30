provider "aws" {
    region = "us-east-1"
}

# to create a VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.10.0.0/16"
}

# to create a subnet

resource "aws_subnet" "demo_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "Demo-subnet"
  }
}

#Create Internet Gateway

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "Demo-igw"
  }
}

# to create route table
resource "aws_route_table" "demo_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "Demo-rt"
  }
}

# to create subnet association ( we need to add our subnet to our route table)
resource "aws_route_table_association" "demo_rt_association" {
  subnet_id = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo_rt.id
}

