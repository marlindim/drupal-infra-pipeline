resource "aws_instance" "drupal_server" {
  count         = 2
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = element([aws_subnet.drupal_subnet_1.id, aws_subnet.drupal_subnet_2.id], count.index)
  vpc_security_group_ids = [aws_security_group.drupal_sg.id]  # <-- use this instead of security_groups
  key_name      = "my-aws-key"

  tags = {
    Name = "drupal-server-${count.index + 1}"
  }
}

