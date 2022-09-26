resource "aws_vpc" "two_layer_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "two_layer_vpc"
  }
}

resource "aws_subnet" "private_db_subnet" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.two_layer_vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    "Name" = each.value.description
  }
}

resource "aws_subnet" "public_web_subnet" {
    for_each = var.public_subnets
    vpc_id = aws_vpc.two_layer_vpc.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone 
    tags = {
      "Name" = each.value.description
    }
}

resource "aws_db_subnet_group" "db_subnet" {
  name = "db_subnet"
  subnet_ids = [for subnet in aws_subnet.private_db_subnet: subnet.id]
}

resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.two_layer_vpc.id
  tags = {
    "Name" = "web_igw"
  }
}

resource "aws_lb" "application_lb" {
  name = "web-application-load-balancer"
  internal = false
  subnets = [for subnet in aws_subnet.public_web_subnet : subnet.id]
  load_balancer_type = "application"
  # access_logs {
  #   bucket = aws_s3_bucket.alb_access_logs.bucket
  #   prefix = "alb_logs"
  #   enabled = true
  # }
  
}