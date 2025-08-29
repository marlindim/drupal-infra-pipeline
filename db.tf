resource "aws_db_subnet_group" "drupal_db_subnet" {
  name       = "drupal-db-subnet"
  description = "Subnet group for Drupal RDS"
  subnet_ids = [
    aws_subnet.drupal_subnet_1.id,
    aws_subnet.drupal_subnet_2.id
  ]

  tags = {
    Name = "drupal-db-subnet"
  }
}
