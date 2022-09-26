variable "public_subnets" {
  type = map(map(string))
  default = {
    "public_web_subnet1" = {
      cidr_block = "10.0.2.0/24"
      availability_zone = "us-east-1a"
      description = "public_subnet_1"
    }
    "public_web_subnet2" = {
        cidr_block = "10.0.3.0/24"
        availability_zone = "us-east-1b"
        description = "public_subnet_2"
    }
  }
}
variable "private_subnets" {
  type = map(map(string))
  default = {
    "private_db_subnet1" = {
      cidr_block = "10.0.4.0/24"
      availability_zone = "us-east-1a"
      description = "private_subnet_1"
    }
    "private_db_subnet2" = {
        cidr_block = "10.0.5.0/24"
        availability_zone = "us-east-1b"
        description = "private_subnet_2"
    }
  }
}


