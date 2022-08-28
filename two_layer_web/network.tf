resource "aws_vpc" "two_layer_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "two_layer_vpc"
  }
}

resource "aws_subnet" "private_db_subnet1" {
    vpc_id = aws_vpc.two_layer_vpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
      "Name" = "private_db_subnet1",
      "subnet_type" = "private"
    }
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_web_subnet1" {
  vpc_id = aws_vpc.two_layer_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      "Name" = "public_web_subnet1",
      "subnet_type" = "public"
    }
    availability_zone = "us-east-1a"
}
resource "aws_subnet" "private_db_subnet2" {
    vpc_id = aws_vpc.two_layer_vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      "Name" = "private_db_subnet2",
      "subnet_type" = "private"
    }
    availability_zone = "us-east-1b"
}

resource "aws_subnet" "public_web_subnet2" {
  vpc_id = aws_vpc.two_layer_vpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      "Name" = "public_web_subnet2",
      "subnet_type" = "public"
    }
    availability_zone = "us-east-1b"
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
#   subnets = [for subnet in aws_subnet.subnet_type.public : subnet.id]
  subnets = [aws_subnet.public_web_subnet1.id, aws_subnet.public_web_subnet2.id]
  load_balancer_type = "application"
  
}