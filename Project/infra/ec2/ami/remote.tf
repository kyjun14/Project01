data "terraform_remote_state" "project01_target" {
    backend = "s3"
    config = {
        bucket = "project01-terraform-state"
        key    = "infra/ec2/target/terraform.tfstate"
        region = "ap-northeast-2"
    }
}