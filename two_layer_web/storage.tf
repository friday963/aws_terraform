#create s3 bucket for alb access logs
#create database, put in private subnet
# resource "aws_s3_bucket" "alb_access_logs" {
#   bucket = "my-alb-access-logs"
# }


resource "aws_db_instance" "private_db" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    db_name                 = "mydb"
    username             = "foo"
    password             = "foobarbaz" 
    multi_az = true
    db_subnet_group_name = aws_db_subnet_group.db_subnet.id
    vpc_security_group_ids = [aws_security_group.db_security_group.id]
}