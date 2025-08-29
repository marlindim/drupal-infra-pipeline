resource "aws_launch_template" "drupal_lt" {
  name_prefix   = "drupal-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Use VPC security group IDs instead of security_groups
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              # Install Apache, PHP, Drupal setup commands
              EOF
}

resource "aws_autoscaling_group" "drupal_asg" {
  desired_capacity    = var.asg_desired
  max_size            = var.asg_max
  min_size            = var.asg_min
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.drupal_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.drupal_tg.arn]
}

