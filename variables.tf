variable "ami_id" {
  description = "AMI ID to use for the Drupal EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Drupal servers"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}
