provider "aws" {
  region = "us-east-2"
}

# -----------------------------------------
# TRY THIS 1ST
# resource "aws_instance" "test" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t3.micro"
#  tags = {
#    Name = "my 1st instance"
#  }
# -----------------------------------------

resource "aws_launch_configuration" "test" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.test.id]

  user_data = <<-EOF
                 #!/bin/bash
                 echo "Hello, World" > index.html
                 nohup busybox httpd -f -p "${var.server_port}" &
                 EOF

  lifecycle {
    create_before_destroy = true
  }


}

resource "aws_security_group" "test" {
  name = "devlin-security-group-demo"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "test" {
  launch_configuration = aws_launch_configuration.test.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = 2
  max_size = 4

  load_balancers    = [aws_elb.test.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "terraform-asg-demo"
    propagate_at_launch = true
  }
}


data "aws_availability_zones" "all" {

}


resource "aws_elb" "test" {
  name               = "terraform-clb-demo"
  security_groups    = [aws_security_group.test2.id]
  availability_zones = data.aws_availability_zones.all.names

  # this adds a listener for incoming HTTP requests
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_security_group" "test2" {
  name = "devlin-security-group-elb"

  # allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

