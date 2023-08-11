resource "aws_ami_from_instance" "project01_target_ami" {
    name = "project01_target_ami"
    source_instance_id = "i-0e881d7ae2d77ec12"
    snapshot_without_reboot = true

    tags = {
        Name = "project01_target_ami"
    }
}