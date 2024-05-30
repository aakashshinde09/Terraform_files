# to create instance
resource "aws_instance" "demo_instance" {
  ami = "ami-00beae93a2d981137"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [ aws_security_group.demo_sg.id ]
}