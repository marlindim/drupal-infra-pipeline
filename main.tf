resource "aws_vpc" "drupal_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true      # allows DNS resolution in the VPC
  enable_dns_hostnames = true      # assigns hostnames to instances in the VPC

  tags = {
    Name = "drupal-vpc"
  }
}

resource "aws_subnet" "drupal_subnet_1" {
  vpc_id     = aws_vpc.drupal_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "drupal-subnet-1" }
}

resource "aws_subnet" "drupal_subnet_2" {
  vpc_id     = aws_vpc.drupal_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "drupal-subnet-2" }
}

resource "aws_internet_gateway" "drupal_ig" {
  vpc_id = aws_vpc.drupal_vpc.id
  tags = { Name = "drupal-ig" }
}

resource "aws_route_table" "drupal_rt" {
  vpc_id = aws_vpc.drupal_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.drupal_ig.id
  }
  tags = { Name = "drupal-rt" }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.drupal_subnet_1.id
  route_table_id = aws_route_table.drupal_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.drupal_subnet_2.id
  route_table_id = aws_route_table.drupal_rt.id
}
