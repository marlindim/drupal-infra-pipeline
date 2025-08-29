resource "aws_lb" "drupal_lb" {
  name               = "drupal-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.drupal_sg.id]
  subnets            = [aws_subnet.drupal_subnet_1.id, aws_subnet.drupal_subnet_2.id]
}

resource "aws_lb_target_group" "drupal_tg" {
  name     = "drupal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.drupal_vpc.id
}

resource "aws_lb_listener" "drupal_listener" {
  load_balancer_arn = aws_lb.drupal_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.drupal_tg.arn
  }
}

