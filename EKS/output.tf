# to get the public ip as the output
output "public_IP_of_instance" {
  description = "This is the public IP of our instance"
  value = aws_instance.demo_instance.public_ip
}

# to get the private ip as the output
output "private_IP_of_our_instance" {
  description = "This is the private IP of our Instance"
  value = aws_instance.demo_instance.private_ip
}