resource "aws_instance" "project01_bastion" {
    ami = data.aws_ami.ubuntu.image_id
    instance_type = "t2.micro"
    key_name = "project01-key"
    vpc_security_group_ids = [data.terraform_remote_state.project01_sg.outputs.project01_ssh_sg]
    subnet_id = data.terraform_remote_state.project01_vpc.outputs.public_subnet2a
    availability_zone = "ap-northeast-2a"
    associate_public_ip_address = true

    tags = {
        Name = "project01_bastion"
    }
}