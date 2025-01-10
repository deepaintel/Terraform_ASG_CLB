resource "aws_launch_template" "lt" {
  name = "ScalingGRPLT"
  image_id = "ami-0de4350790d524675"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = ["sg-01747d01295d87dbc"]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "My-ASG-Instance" # Replace with your desired instance name
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name             = "AutoScalingGroup"
  max_size         = 3
  min_size         = 2
  desired_capacity = 2
  force_delete     = true
  vpc_zone_identifier = ["subnet-075138f1725a033c8", "subnet-0302592226038a219"]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  load_balancers = [aws_elb.clbdemo.id]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "My-ASG-Instance"
    propagate_at_launch = true
  }
}


