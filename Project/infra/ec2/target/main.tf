resource "aws_instance" "project01_target" {
    ami = data.aws_ami.ubuntu.image_id
    instance_type = "t2.micro"
    key_name = "project01-key"
    vpc_security_group_ids = [data.terraform_remote_state.project01_sg.outputs.project01_web_sg]
    subnet_id = data.terraform_remote_state.project01_vpc.outputs.private_subnet2a
    availability_zone = "ap-northeast-2a"
    associate_public_ip_address = false
    iam_instance_profile = "project01-codedeploy-ec2-role"

    user_data = "${file("install.sh")}"

    tags = {
        Name = "project01_target"
    }
}