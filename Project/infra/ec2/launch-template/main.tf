resource "aws_launch_template" "project01-launch-template" {
    name                   = "project01-launch-template"
    image_id               = data.terraform_remote_state.project01_target_ami.outputs.ami_id
    instance_type          = "t2.micro"
    key_name               = "project01-key"
    vpc_security_group_ids = [data.terraform_remote_state.project01_sg.outputs.project01_web_sg, data.terraform_remote_state.project01_sg.outputs.project01_ssh_sg]
    iam_instance_profile {
        name = "project01-codedeploy-ec2-role"
    }

    tags = {
        Name = "project01-code-deploy-instance"
    }

    lifecycle {
        create_before_destroy = true
    }  
}

resource "aws_autoscaling_group" "project01-asg" {
    vpc_zone_identifier = [data.terraform_remote_state.project01_vpc.outputs.private_subnet2a, data.terraform_remote_state.project01_vpc.outputs.private_subnet2c]

    name             = "project01-group"
    desired_capacity = 3
    min_size         = 3
    max_size         = 3

    launch_template {
        id = aws_launch_template.project01-launch-template.id
        version = "$Latest"
    } 

    tag {
        key                 = "Name"
        value               = "project01-group"
        propagate_at_launch = true
    }
}