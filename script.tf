# Specify region
provider "aws" {
    region = "us-east-1"
}

# Creating a new ssh key pair
resource "aws_key_pair" "akash_key" {
    key_name = "akash-key"
    public_key = file("~/.ssh/authorized_keys") 
    # The above is the path where our public key is stored
}

# Creating a new Security Group
resource "aws_security_group" "akash_sg" {
    name = "akash-sg"
    description = "Security Group for akash instance"

    # Now we need to create inbound and outbound rules for our security group

    # ingress is used for inbound rules

    # ingress (inbound rule) for SSH

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ingress (inbound rule) for HTTP
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ingress (inbound rule) for HTTPS

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # egress (outbound rule) for all ports and all protocols

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# to create an instance 
resource "aws_instance" "akash" {
    ami = "ami-00beae93a2d981137"
    instance_type = "t2.micro"
    key_name = aws_key_pair.akash_key.key_name
    vpc_security_group_ids = [aws_security_group.akash_sg.id]

    tags = {
        Name = "akash-instance" # Tag is used to give name to the instance
    }
}
