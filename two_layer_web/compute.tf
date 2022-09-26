data "aws_ami" "compute_data_source" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220912.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.compute_data_source.id
  instance_type = "t3.micro"

  tags = {
    Name = "web server"
  }
}