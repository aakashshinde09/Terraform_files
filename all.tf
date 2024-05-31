provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "akash_key" {
  key_name = "akash-key"
  public_key = file("~/.ssh/authorized_keys")
}

resource "aws_security_group" "akash_sg" {
  name = "akash-sg"
  description = "security group for the instance"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]


  }
}

resource "aws_instance" "akash_instance" {
  ami = data.aws_ami.aws_linux.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.akash_key.key_name
  vpc_security_group_ids = [aws_security_group.akash_sg.id]

  tags = {
    Name = "akash-instance"
  }
}

output "ami_id" {
  value = data.aws_ami.aws_linux
}


data "aws_ami" "aws_linux" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-5.10-hvm-2.0.20240529.0-arm64-gp2" ]
  }
}