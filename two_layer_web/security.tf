resource "aws_security_group" "db_security_group" {
  name        = "Allow Database connections"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.two_layer_vpc.id

  ingress {
    description      = "MySQL Security Group"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.two_layer_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  tags = {
    Name = "MySQL Security Group"
  }
}