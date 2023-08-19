resource "aws_ami_from_instance" "project01_target_ami" {
    name                    = "project01_target_ami"
    source_instance_id      = data.terraform_remote_state.project01_target.outputs.instance_id
    snapshot_without_reboot = true

    tags = {
        Name = "project01_target_ami"
    }
}