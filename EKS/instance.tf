# to create instance
resource "aws_instance" "demo_instance" {
  ami = var.ami
  instance_type = var.instance-type
  associate_public_ip_address = true
  subnet_id = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [ aws_security_group.demo_sg.id ]

  tags = {
    Name = "demo-instance"
  }
}