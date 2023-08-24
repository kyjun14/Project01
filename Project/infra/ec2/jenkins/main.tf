resource "aws_instance" "project01_jenkins" {
    ami = data.aws_ami.ubuntu.image_id
    instance_type = "t3.large"
    key_name = "project01-key"
    iam_instance_profile = "project01-codedeploy-ec2-role"
    vpc_security_group_ids = [data.terraform_remote_state.project01_sg.outputs.project01_ssh_sg, data.terraform_remote_state.project01_sg.outputs.project01_web_sg]
    subnet_id = data.terraform_remote_state.project01_vpc.outputs.private_subnet2a
    availability_zone = "ap-northeast-2a"
    associate_public_ip_address = false
    private_ip = "10.1.128.100"

    user_data = "${file("install.sh")}"
                
    tags = {
        Name = "project01-jenkins"
    }
}