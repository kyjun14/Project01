data "terraform_remote_state" "project01_vpc" {
    backend = "s3"
    config = {
        bucket = "project01-terraform-state"
        key    = "infra/network/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}