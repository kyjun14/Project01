resource "aws_lb" "project01-lb" {
  name = "project01-lb"
  load_balancer_type = "application"
  security_groups = [data.terraform_remote_state.project01_sg.outputs.project01_lb_sg]
  subnets = [data.terraform_remote_state.project01_vpc.outputs.public_subnet2a, data.terraform_remote_state.project01_vpc.outputs.public_subnet2c]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.project01-lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
	  type = "forward"
    target_group_arn = aws_lb_target_group.project01-target-group.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.project01-lb.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = "arn:aws:acm:ap-northeast-2:257307634175:certificate/8238361a-128b-464c-81fe-c4108d9e5ab2"

  default_action {
	  type = "forward"
    target_group_arn = aws_lb_target_group.project01-target-group.arn
  }

}

resource "aws_lb_listener_rule" "jenkins-http" {
  listener_arn = aws_lb_listener.http.arn
  priority = 1

  condition {
    host_header {
      values = ["jenkins01.busanit-lab.com"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.project01-jenkins-group.arn
  }

  tags = {
    Name = "jenkins"
  }
}

resource "aws_lb_listener_rule" "jenkins-https" {
  listener_arn = aws_lb_listener.https.arn
  priority = 1

  condition {
    host_header {
      values = ["jenkins01.busanit-lab.com"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.project01-jenkins-group.arn
  }

  tags = {
    Name = "jenkins"
  }
}

resource "aws_lb_target_group" "project01-target-group" {
  name = "project01-target-group"
  port = 8080
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.project01_vpc.outputs.vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "project01-jenkins-group" {
  name = "project01-jenkins-group"
  port = 8080
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.project01_vpc.outputs.vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}