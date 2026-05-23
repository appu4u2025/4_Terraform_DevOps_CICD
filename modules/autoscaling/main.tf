variable "ami_id" {}
variable "instance_type" {}
variable "security_group_id" {}
variable "subnets" {}
variable "target_group_arn" {}

resource "aws_launch_template" "lt" {
    name_prefix = "terraform-lt"
    image_id = var.ami_id
    instance_type = var.instance_type

    vpc_security_group_ids = [var.security_group_id]
    user_data = base64encode(<<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "Hello from Terraform ASG" > /var/www/html/index.html
    EOF
    )
}

resource "aws_autoscaling_group" "asg" {
desired_capacity = 2
max_size = 3
min_size = 1

vpc_zone_identifier = var.subnets
target_group_arns = [var.target_group_arn]

launch_template {
  id = aws_launch_template.lt.id
  version = "$Latest"
}
health_check_type = "EC2"
}
