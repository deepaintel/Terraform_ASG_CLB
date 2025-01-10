resource "aws_elb" "clbdemo" {
  name = "scalinglbdemo"
  subnets = ["subnet-075138f1725a033c8", "subnet-0302592226038a219"]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    target              = "HTTP:80/index.html"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name = "asg-clb"
  }
}

