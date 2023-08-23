resource "aws_security_group" "project01_ssh_sg" {
    name        = "project01_ssh_sg"
    description = "Security group for SSH server"
    vpc_id      = data.terraform_remote_state.project01_vpc.outputs.vpc_id
    
    ingress {
        description = "For SSH port"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol     = "-1"
        from_port    = 0
        to_port      = 0
        cidr_blocks  = ["0.0.0.0/0"]
    }

    tags = {
        Name = "project01_ssh_sg"
    }
}

resource "aws_security_group" "project01_web_sg" {
    name = "project01_web_sg"
    description = "Security group for web server"
    vpc_id = data.terraform_remote_state.project01_vpc.outputs.vpc_id

    ingress {
        description = "For web port"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
        protocol  = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "project01_web_sg"
    }
}

resource "aws_security_group" "project01_lb_sg" {
    name = "project01_lb_sg"
    description = "Security group for ALB"
    vpc_id = data.terraform_remote_state.project01_vpc.outputs.vpc_id

    ingress {
      description = "For Jenkins port"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol  = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "For ALB port"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol  = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "For ALB port"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol  = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "project01_lb_sg"
    }
}



