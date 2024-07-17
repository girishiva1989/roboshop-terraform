resource "aws_instance" "frontend" {
  ami           = ami-0b4f379183e5706b9
  instance_type = "t3.small"

  tags = {
    Name = "frontend"
  }
}