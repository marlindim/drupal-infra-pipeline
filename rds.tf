resource "aws_db_instance" "drupal_db" {
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0.42"   # supported version
  instance_class          = "db.t3.micro"
  db_name                 = "drupaldb"
  username                = "admin"
  password                = "Password123!"
  skip_final_snapshot     = true
  multi_az                = true
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.drupal_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.drupal_db_subnet.name
}

